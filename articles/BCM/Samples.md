# BCM .NET Client API Samples

## Operations with comments
### Get all the comments in a BCM Document
```csharp
Document document; // a BCM Document deserialized from JSON

IEnumerable<SegmentPair> allSegmentPairs = document.Files.Select(file => file.ParagraphUnits).SelectMany(p => p.AllSegmentPairs);

List<CommentContainer> sourceComments = allSegmentPairs.Select(segmentPair => segmentPair.Source)
                                                                .SelectMany(segment => segment.AllSubItems.OfType<CommentContainer>())
                                                                .ToList();

List<CommentContainer> targetComments = allSegmentPairs.Select(sp => sp.Target)
                                                        .SelectMany(segment => segment.AllSubItems.OfType<CommentContainer>())
                                                        .ToList();
foreach (var comment in sourceComments)
{
    Console.WriteLine($"Source comment in segment {comment.ParentSegment.SegmentNumber} with text {comment.Definition.Text}");
}
foreach (var comment in targetComments)
{
    Console.WriteLine($"Target comment in segment {comment.ParentSegment.SegmentNumber} with text {comment.Definition.Text}");
}
```

### Add a comment over a text element
```csharp
Document document; // a BCM Document deserialized from JSON

var definition = new CommentDefinition
{
    Text = "new comment",
    CommentSeverity = CommentSeverity.Medium,
    Author = "author",
    Date = DateTime.Now
};

var comment = new CommentContainer
{
    CommentDefinitionId = definition.Id
};

// Find a text element on which to add a Comment
var text = document.Files.First().ParagraphUnits.SelectMany(x => x.Target.AllSubItems.OfType<TextMarkup>()).First();

// Remove the Text from its current parent
var parentElement = text.Parent;
var indexInParent = text.IndexInParent;
parentElement.Remove(text);
// Add the Text to the newly created Comment element
comment.Add(text);
// Insert the new Comment element to replace the Text, in the same position
parentElement.Insert(indexInParent, comment);
```

### Remove a comment
```csharp
Document document; // a BCM Document deserialized from JSON
var comment = document.Files.First().ParagraphUnits.SelectMany(x => x.Target.AllSubItems.OfType<CommentContainer>()).First();

// Remove it from the FileSkeleton, where the Comment data is stored
document.Files.First().Skeleton.CommentDefinitions.Remove(comment.Definition);

// Remove the Comment from its parent element
comment.Parent.Remove(comment);       
```

## BCM Visitor
This sample gathers the translatable content from a BCM documents and creates a HTML file with the content.
### HtmlOutputVisitor
```csharp
using Sdl.Core.Bcm.BcmModel;
using Sdl.Core.Bcm.BcmModel.Annotations;
using Sdl.Core.Bcm.BcmModel.Common;
using System.Text;

namespace Sdl.Core.Bcm.API.Samples.Visitor
{
    class HtmlOutputVisitor : BcmVisitor
    {
        // Gathers HTML content from the BCM content.
        private readonly StringBuilder _result = new StringBuilder();

        /// <summary>
        /// Creates a new instance of <see cref="HtmlOutputVisitor"/> and gathers content as HTML from <paramref name="markupData"/> and all its descendant elements.
        /// </summary>
        /// <param name="markupData">The <see cref="MarkupData"/> element from which to extract HTML content.</param>
        /// <returns></returns>
        public static string Collect(MarkupData markupData)
        {
            var collector = new HtmlOutputVisitor();
            markupData.AcceptVisitor(collector);
            return collector.Result;
        }

        /// <summary>
        /// After <see cref="Collect(MarkupData)"/> is called, this will contain the HTML output text.
        /// </summary>
        /// <value>
        /// The result.
        /// </value>
        public string Result => _result.ToString();

        /// <summary>
        /// Visits all the descendant elements of <paramref name="container"/>.
        /// </summary>
        /// <param name="container">The container.</param>
        public void VisitChildren(MarkupDataContainer container)
        {
            foreach (var markupData in container.Children)
            {
                markupData.AcceptVisitor(this);
            }
        }

        /// <summary>
        /// Visits the descendants of a Comment element.
        /// </summary>
        /// <param name="commentContainer"></param>
        public override void VisitCommentContainer(CommentContainer commentContainer)
        {
            VisitChildren(commentContainer);
        }

        /// <summary>
        /// Visits the descendants of a Feedback element.
        /// </summary>
        /// <param name="feedbackContainer"></param>
        public override void VisitFeedbackContainer(FeedbackContainer feedbackContainer)
        {
            VisitChildren(feedbackContainer);
        }

        /// <summary>
        /// Visits the descendants of a Locked Content element.
        /// </summary>
        /// <param name="lockedContentContainer"></param>
        public override void VisitLockedContentContainer(LockedContentContainer lockedContentContainer)
        {
            VisitChildren(lockedContentContainer);
        }

        /// <summary>
        /// Visits the target <see cref="Paragraph"/> and wraps its content inside a DIV tag.
        /// </summary>
        /// <param name="paragraph"></param>
        public override void VisitParagraph(Paragraph paragraph)
        {
            _result.Append($"<div type=\"paragraph\">");

            VisitChildren(paragraph);

            _result.Append($"</div>");
        }

        /// <summary>
        /// Visits a <see cref="PlaceholderTag"/> non-translatable element and appends its content as a VAR tag.
        /// </summary>
        /// <param name="tag"></param>
        public override void VisitPlaceholderTag(PlaceholderTag tag)
        {
            _result.Append($"<var id=\"{tag.Id}\">{tag.Definition.DisplayText}</var>");
        }

        public override void VisitRevisionContainer(RevisionContainer revisionContainer)
        {
            VisitChildren(revisionContainer);
        }

        /// <summary>
        /// Visits a <see cref="Segment"/> translatable element and appends its content as a DIV tag.
        /// </summary>
        /// <param name="segment"></param>
        public override void VisitSegment(Segment segment)
        {
            _result.Append($"<div type=\"segment\" id=\"{segment.Id}\">");

            VisitChildren(segment);

            _result.Append($"</div>");
        }

        /// <summary>
        /// Structure elements are non-translatable elements which are ignored during the translation process.
        /// </summary>
        /// <param name="structureTag">The structure tag.</param>
        public override void VisitStructure(StructureTag structureTag)
        {
        }

        /// <summary>
        /// Visits a <see cref="TagPair"/> element and appends its content as a SPAN tag. 
        /// Tag pairs are non-translatable elements which can contain translatable content. 
        /// E.g.: Bold formatting (<b>text</b>). The start and end Bold tags form the tag pair and the text is a child element.
        /// </summary>
        /// <param name="tagPair"></param>
        public override void VisitTagPair(TagPair tagPair)
        {
            _result.Append($"<span id=\"{tagPair.Id}\">");

            VisitChildren(tagPair);

            _result.Append("</span>");
        }

        /// <summary>
        /// Visits the descendants of a Terminology Annotation element.
        /// </summary>
        /// <param name="terminologyAnnotation"></param>
        public override void VisitTerminologyContainer(TerminologyAnnotationContainer terminologyAnnotation)
        {
            VisitChildren(terminologyAnnotation);
        }

        /// <summary>
        /// Visits a <see cref="TextMarkup"/> element and appends its content as plain text.
        /// These are translatable text elements.
        /// </summary>
        /// <param name="text"></param>
        public override void VisitText(TextMarkup text)
        {
            _result.Append(text.Text);
        }
    }
}
```
### Usage
```csharp
Document document; // a BCM Document deserialized from JSON

var visitor = new HtmlOutputVisitor();

// Surround content with an <html> tag.
var result = new StringBuilder("<html>");

// Extract content from each BCM File.
// A File represents the content extracted from a native file. A BCM Document can have content extracted from multiple files.
document.Files.ForEach(file =>
{
    // Get all the target content in a File
    var targetSegments = file.ParagraphUnits.Select(punit => punit.Target);

    foreach (var targetSegment in targetSegments)
    {
        // Visit each target Segment and append its content as HTML
        result.Append(HtmlOutputVisitor.Collect(targetSegment));
    }
});

result.Append("</html>");
```

