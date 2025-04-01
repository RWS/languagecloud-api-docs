# File formats
A file used in the Trados Cloud Platform API can have one of the three supported formats: native, SDLXLIFF or [BCM](https://developers.rws.com/languagecloud-api-docs/articles/BCM.NET_client_API.html):

- Native represents the format of the file that is attached to a project by the user. The project's associated File Type Configuration specifies if the native file extensions can be attached to that project.

- To download files for translation or review in offline mode, the *.sdlxliff format can be used. SDLXLIFF files have XML format.

- BCM (Bilingual Content Model) documents are files used for handling content internally. BCM files have JSON content and are stored in .json format.   

## File formats in a workflow
In a workflow, each task has a supported input file type that describes which input file types are allowed for that task. A new file version can be added only if the format of this new version respects the input file type supported by the task. You can check what the supported input file types are for tasks on the [Rules for sequencing tasks correctly](https://docs.rws.com/791595/885137/trados-enterprise/rules-for-sequencing-tasks-correctly) page.

A few input file types and examples of tasks that support them are listed below:

- nativeSource: the task handles source file versions in their uploaded native format (e.g.: *FileTypeDetection*, *Engineering*, *FileFormatConversion*)
- bcmSource: the task can process source files in their BCM format (e.g.: *DocumentContentAnalysis*, *CopySourceToTarget*)
- bcmTarget: the task accepts target files in their BCM format (e.g.: *Translation*, *Linguistic Review*, *MachineTranslation*, *TranslationMemoryMatching*, *TranslationMemoryUpdate*, *TargetFileGeneration*)
- nativeTarget: the task handles target files in their native "generated" form (e.g.: *DTP*, *FinalCheck*)
- sdlxliffTarget: the task processes target files in their SDLXLIFF form. Specifically for Import tasks. 
- none: the task does not read or modify the content of a file.

Using the Trados Cloud Platform API, the source and target files in different formats can be viewed, downloaded and added (via import operations), based on the task and its status in the project's workflow.

### Handling Source Files

#### Upload Source Files
Source files can be added to a project using the [Add Source File](../reference/Public-API.v1.json/paths/~1projects~1{projectId}~1source-files/post) endpoint or the [Attach Source Files](../reference/Public-API.v1.json/paths/~1projects~1{projectId}~1source-files~1attach-files/post) endpoint (for multiple files). If the file's extension is supported by the File Type Configuration, the project will follow the workflow and a new version of the source file in BCM format will be automatically created in the *File Format Conversion* task. 


#### Upload Source File Versions
New source file versions can be added in native or BCM format using the [Add Source File Version](../reference/Public-API.v1.json/paths/~1tasks~1{taskId}~1source-files~1{sourceFileId}~1versions/post) endpoint. You can add source file versions:
* in the *Engineering* task
* in custom tasks created by users having the task type set to *Engineering*
* in extension tasks that handle source files.

If a project having attached a native source file with an unsupported extension is started, an error task will be generated in the *File Type Detection* task and the workflow is interrupted.

>Note: For adding a source file version using an extension task, the configuration of the task type must declare the `scope`'s value as "file". 


#### Download Source File Versions
Any of the source file versions (in native or BCM format) can be downloaded using the [Download Source File Version](../reference/Public-API.v1.json/paths/~1projects~1{projectId}~1source-files~1{sourceFileId}~1versions~1{fileVersionId}~1download/get) endpoint. The *Engineering* task, for instance, is an example of a task where download can be performed.



### Handling Target Files
The *Copy source to target* task converts the native file to a new target file version in BCM format.

#### Upload Target File Versions
Adding a new version for a target file in native or BCM format can be executed with the [Add Target File Version](../reference/Public-API.v1.json/paths/~1tasks~1{taskId}~1target-files~1{targetFileId}~1versions/post) endpoint.

>Note: For adding a target file version using an extension task, the configuration of the task type must declare the `scope`'s value as "file". 


#### Download Target File Versions
The BCM and native target file versions can be downloaded by using [Download Target File Version](../reference/Public-API.v1.json/paths/~1projects~1{projectId}~1target-files~1{targetFileId}~1versions~1{fileVersionId}~1download/get) endpoint, while the project is, for example, in the *Translation* task.


#### Export Target File Versions
The BCM target file versions can be exported in native or SDLXLIFF format by calling the [Export Target File Version](../reference/Public-API.v1.json/paths/~1projects~1{projectId}~1target-files~1{targetFileId}~1versions~1{fileVersionId}~1exports/post) endpoint. This operation triggers a conversion of the BCM target file version in a native or SDLXLIFF format based on the value of the `format` query parameter used. The endpoint starts an export operation which can be monitored using the [polling endpoint](../reference/Public-API.v1.json/paths/~1projects~1{projectId}~1target-files~1{targetFileId}~1versions~1{fileVersionId}~1exports~1{exportId}/get). After the export is done, the files can be downloaded using the [Download Exported Target File Version](../reference/Public-API.v1.json/paths/~1projects~1{projectId}~1target-files~1{targetFileId}~1versions~1{fileVersionId}~1exports~1{exportId}~1download/get) endpoint. 

> Note: The export endpoint is dedicated to file versions of BCM format and cannot be used on files in native or SDLXLIFF format. The export operation can only be executed on tasks where the supported output file is a bilingual target file. You can consult the output file types for tasks on the [Rules for sequencing tasks correctly](https://docs.rws.com/791595/885137/trados-enterprise/rules-for-sequencing-tasks-correctly) page from the official RWS Documentation Center.
>
>In order to download file versions of BCM or native type, please use the [Download Target File Version](../reference/Public-API.v1.json/paths/~1projects~1{projectId}~1target-files~1{targetFileId}~1versions~1{fileVersionId}~1download/get) endpoint.


#### Import Target File Versions
Target file versions downloaded in SDLXLIFF format can be processed and afterwards replaced by using [Import Target File Version](../reference/Public-API.v1.json/paths/~1projects~1{projectId}~1target-files~1{targetFileId}~1versions~1imports/post) endpoint. The import operation triggers internally the update of the BCM file associated with the imported SDLXLIFF file. This endpoint should mostly be used for offline work.
