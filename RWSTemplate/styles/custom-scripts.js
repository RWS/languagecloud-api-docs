// Handle navigation for #/operations/ and #/schemas/ links when using router="memory"
document.addEventListener('DOMContentLoaded', function () {
  const apiElement = document.getElementById('api-docs');

  // Handle initial page load with hash
  if (window.location.hash && (window.location.hash.startsWith('#/operations/') || window.location.hash.startsWith('#/schemas/'))) {
    setTimeout(() => {
      const hash = window.location.hash;
      const route = hash.substring(1);
      if (apiElement) {
        apiElement.setAttribute('basePath', route);
      }
    }, 500);
  }
});

(function () {
  let operationMap = {};
  let operationToTagMap = {}; // Map operationId to tag name (from spec)
  let specData = null; // Store the loaded spec

  function init() {
    const elementsApi = document.querySelector('elements-api');
    if (!elementsApi) {
      console.log("No <elements-api> found, skipping OperationID result injection.");
      return;
    }

    const specUrl = elementsApi.getAttribute('apiDescriptionUrl');
    if (!specUrl) {
      console.log("No apiDescriptionUrl found on <elements-api>, skipping.");
      return;
    }

    console.log('Fetching spec for OperationID injection...', specUrl);
    fetch(specUrl)
      .then(response => response.json())
      .then(spec => {
        specData = spec;
        buildMappingsFromSpec(spec);
        injectTagIds();
        startObserver();
      })
      .catch(err => console.error('Failed to load spec for operationId injection', err));
  }

  function buildMappingsFromSpec(spec) {
    if (spec.paths) {
      for (const [path, methods] of Object.entries(spec.paths)) {
        for (const [method, op] of Object.entries(methods)) {
          if (op.operationId) {
            // Build operation map for injection (method/path -> operationId)
            const key = `${method.toUpperCase()} ${path}`;
            operationMap[key] = op.operationId;

            // Build operationId to tag mapping from spec
            if (op.tags && op.tags.length > 0) {
              operationToTagMap[op.operationId] = op.tags[0]; // Use first tag
              console.log(`Mapped ${op.operationId} to tag: ${op.tags[0]}`);
            }
          }
        }
      }
    }
    console.log('Spec loaded. Operation map size:', Object.keys(operationMap).length);
    console.log('Operation to tag map size:', Object.keys(operationToTagMap).length);
  }

  function injectTagIds() {
    // Find all tag name elements first
    const tagNameElements = document.querySelectorAll('.sl-text-lg.sl-font-medium');

    console.log(`Found ${tagNameElements.length} tag name elements to inject IDs`);

    if (tagNameElements.length === 0) {
      console.log('No tag name elements found yet, retrying in 1 second...');
      setTimeout(injectTagIds, 1000);
      return;
    }

    tagNameElements.forEach(tagNameEl => {
      const tagName = tagNameEl.textContent.trim();
      const parentElement = tagNameEl.parentElement;

      if (parentElement && !parentElement.getAttribute('data-oas-tag-id')) {
        parentElement.setAttribute('data-oas-tag-id', tagName);
        console.log(`Injected tag ID: ${tagName} on parent element:`, parentElement);
      }
    });
  }

  function startObserver() {
    const observer = new MutationObserver((mutations) => {
      injectOperationIds();
      injectTagIds(); // Also retry tag ID injection when DOM changes
    });

    // Observer the body or the <elements-api> container if possible
    const target = document.querySelector('elements-api') || document.body;
    observer.observe(target, { childList: true, subtree: true });

    // Also run immediately
    injectOperationIds();
  }

  function injectOperationIds() {
    // Target the operation method/path container.
    const containers = document.querySelectorAll('.sl-flex.sl-items-center');

    containers.forEach(container => {
      if (container.dataset.opIdInjected) return;

      const methodEl = container.querySelector('.sl-uppercase');
      if (!methodEl) return;

      // The path element is usually a div sibling.
      let pathEl = null;
      for (const child of container.children) {
        if (child !== methodEl && child.textContent.trim().startsWith('/')) {
          pathEl = child;
          break;
        }
      }

      if (methodEl && pathEl) {
        const method = methodEl.textContent.trim().toUpperCase();
        const path = pathEl.textContent.trim();
        const key = `${method} ${path}`;

        const operationId = operationMap[key];

        if (operationId) {
          // path (operationPath) used by copy button
          const operationPath = path;
          // 1. Create a wrapper
          const wrapper = document.createElement('span');
          wrapper.style.display = 'inline-flex';
          wrapper.style.alignItems = 'center';

          // 2. Operation ID Badge (badge contains copy button and inline copy button)
          const badge = document.createElement('span');
          badge.style.display = 'inline-flex';
          badge.style.alignItems = 'center';
          badge.style.fontSize = '12px';
          badge.style.color = '#555';
          badge.style.marginLeft = '0';
          badge.style.fontFamily = 'monospace';
          badge.style.backgroundColor = '#ffffff';
          badge.style.boxShadow = '0 1px 4px rgba(0,0,0,0.08)';
          badge.style.padding = '2px';
          badge.style.borderRadius = '4px';
          badge.style.border = '1px solid #ddd';
          badge.className = 'inserted-operation-id-badge';

          // Copy button (click copies the operation path)
          const copyBtn = document.createElement('button');
          copyBtn.type = 'button';
          copyBtn.innerHTML = '<svg xmlns="http://www.w3.org/2000/svg" width="80%" height="80%" fill="none" viewBox="0 0 24 24" stroke-width="1.6" stroke="currentColor" style="display:block;width:80%;height:80%"> <path stroke-linecap="round" stroke-linejoin="round" d="M13.19 8.688a4.5 4.5 0 0 1 1.242 7.244l-4.5 4.5a4.5 4.5 0 0 1-6.364-6.364l1.757-1.757m13.35-.622 1.757-1.757a4.5 4.5 0 0 0-6.364-6.364l-4.5 4.5a4.5 4.5 0 0 0 1.242 7.244" /> </svg>';
          copyBtn.title = `Copy path: ${operationPath}`;
          copyBtn.setAttribute('aria-label', `Copy path ${operationPath}`);
          copyBtn.style.font = 'inherit';
          copyBtn.style.color = 'inherit';
          copyBtn.style.background = 'transparent';
          copyBtn.style.border = 'none';
          copyBtn.style.padding = '0';
          copyBtn.style.margin = '0';
          copyBtn.style.cursor = 'pointer';
          copyBtn.style.display = 'inline-flex';
          copyBtn.style.alignItems = 'center';
          copyBtn.style.justifyContent = 'center';
          copyBtn.style.boxSizing = 'border-box';
          copyBtn.style.backgroundClip = 'padding-box';
          copyBtn.style.borderRadius = '4px';
          copyBtn.className = 'inserted-operation-id';

          // Copy-to-clipboard behavior (copies the operation path, e.g. "/resource/{id}")
          copyBtn.addEventListener('click', async (e) => {
            e.preventDefault();
            // Prevent the click from bubbling to the collapsible header
            e.stopPropagation();
            const textToCopy = operationPath;
            try {
              if (navigator.clipboard && navigator.clipboard.writeText) {
                await navigator.clipboard.writeText(textToCopy);
              } else {
                // Fallback for older browsers
                const ta = document.createElement('textarea');
                ta.value = textToCopy;
                ta.style.position = 'fixed';
                ta.style.opacity = '0';
                document.body.appendChild(ta);
                ta.select();
                document.execCommand('copy');
                document.body.removeChild(ta);
              }

              // Temporary feedback (show SVG checkmark briefly)
              const original = copyBtn.innerHTML;
              copyBtn.innerHTML = '<svg xmlns="http://www.w3.org/2000/svg" width="80%" height="80%" fill="none" viewBox="0 0 24 24" stroke-width="1.6" stroke="currentColor" style="display:block;width:80%;height:80%"> <path stroke-linecap="round" stroke-linejoin="round" d="m4.5 12.75 6 6 9-13.5" /> </svg>';
              setTimeout(() => { copyBtn.innerHTML = original; }, 1000);
            } catch (err) {
              console.error('Copy failed', err);
            }
          });

          badge.appendChild(copyBtn);

          // 3. Anchor ID 
          const anchorId = `/operations/${operationId}`;

          wrapper.appendChild(badge);

          const parent = container.parentElement || container;
          if (parent) {
            if (getComputedStyle(parent).position === 'static') {
              parent.style.position = 'relative';
            }
            wrapper.style.position = 'absolute';
            wrapper.style.top = '50%';
            wrapper.style.transform = 'translateY(-50%)';
            wrapper.style.right = '12px';
            wrapper.style.zIndex = '9999';
            wrapper.style.pointerEvents = 'auto';
            try { parent.style.overflow = 'visible'; } catch (e) { /* ignore */ }
            copyBtn.style.width = '20px';
            copyBtn.style.height = '20px';

            parent.appendChild(wrapper);
          } else {
            // fallback to previous behavior
            container.appendChild(wrapper);
          }
          if (!container.id) {
            container.id = anchorId;
          }

          container.dataset.opIdInjected = 'true';

          // 5. Check if we need to scroll to this hash (if page loaded with this hash)
          if (window.location.hash === `#${anchorId}`) {
            setTimeout(() => {
              navigateToOperation(operationId);
            }, 1000); // Give more time for all content to load
          }
        }
      }
    });
  }

  // Get tag name from tag section header
  function getTagName(tagSection) {
    const tagNameEl = tagSection.querySelector('.sl-text-lg.sl-font-medium');
    return tagNameEl ? tagNameEl.textContent : 'Unknown';
  }

  // Handle hash changes for navigation
  function handleHashChange() {
    const hash = window.location.hash;
    if (hash.startsWith('#/operations/')) {
      const operationId = hash.replace('#/operations/', '');
      navigateToOperation(operationId);
    }
  }

  // Navigate to a specific operation by operationId
  function navigateToOperation(operationId) {
    console.log(`Navigating to operation: ${operationId}`);

    // First, try to find the operation by the injected anchor
    const anchorId = `/operations/${operationId}`;
    let targetElement = document.getElementById(anchorId);

    if (targetElement && isElementVisible(targetElement)) {
      // Found it and it's visible, scroll to it
      console.log(`Operation ${operationId} found and visible, scrolling directly`);
      scrollToAndHighlight(targetElement);
      return;
    }

    // Use the spec-based mapping to find the correct tag section
    const tagName = operationToTagMap[operationId];
    if (tagName) {
      console.log(`Operation ${operationId} belongs to tag: ${tagName}`);

      // Find the tag section by the injected data-oas-tag-id
      const tagSection = document.querySelector(`[data-oas-tag-id="${tagName}"]`);
      if (tagSection) {
        console.log(`Found tag section for: ${tagName}`);

        if (!isTagSectionExpanded(tagSection)) {
          console.log(`Jumping to and expanding tag section: ${tagName}`);

          // Jump directly to the tag section
          tagSection.scrollIntoView({ behavior: 'auto', block: 'start' });

          // Expand the tag section
          tagSection.click();

          // Immediately find and highlight the operation (no delay)
          console.log(`Tag section expanded, immediately navigating to operation: ${operationId}`);
          findAndScrollToOperation(operationId);
        } else {
          console.log(`Tag section ${tagName} already expanded, finding operation`);
          // Tag section already expanded, find the operation immediately
          findAndScrollToOperation(operationId);
        }
      } else {
        console.warn('Tag section not found for tag: %s. Available tag sections:', tagName,
          Array.from(document.querySelectorAll('[data-oas-tag-id]')).map(el => el.getAttribute('data-oas-tag-id')));
      }
    } else {
      console.warn('No tag mapping found for operation: %s. Available operations:', operationId, Object.keys(operationToTagMap));
      console.log('No fallback - operation not found in mapping');
    }
  }

  // Check if element is visible in the viewport
  function isElementVisible(element) {
    const rect = element.getBoundingClientRect();
    return rect.height > 0 && rect.width > 0;
  }

  // Find and scroll to operation after tag section is expanded
  function findAndScrollToOperation(operationId) {
    const anchorId = `/operations/${operationId}`;
    let targetElement = document.getElementById(anchorId);

    if (!targetElement) {
      console.warn(`Operation element not found with ID: ${anchorId}`);
      return;
    }

    console.log(`Found operation ${operationId}, scrolling to center and highlighting`);
    scrollToAndHighlight(targetElement);
  }

  // Check if a tag section is expanded
  function isTagSectionExpanded(tagSection) {
    const chevron = tagSection.querySelector('svg[data-icon="chevron-down"], svg[data-icon="chevron-right"]');
    return chevron && chevron.getAttribute('data-icon') === 'chevron-down';
  }

  // Scroll to element and highlight it
  function scrollToAndHighlight(element) {
    console.log('Scrolling to and highlighting operation');

    // Use requestAnimationFrame and retry logic for reliable scrolling
    const performScroll = (retries = 3) => {
      requestAnimationFrame(() => {
        // Check if element is properly positioned
        const rect = element.getBoundingClientRect();
        if (rect.height === 0 && retries > 0) {
          console.log('Element not yet positioned, retrying scroll...');
          setTimeout(() => performScroll(retries - 1), 300);
          return;
        }

        // Stop any existing smooth scrolling
        window.scrollTo({ top: window.pageYOffset, behavior: 'auto' });

        // Small delay to let any competing scrolls settle
        setTimeout(() => {
          element.scrollIntoView({
            behavior: 'smooth',
            block: 'center',
            inline: 'nearest'
          });

          // Highlight after scrolling starts
          setTimeout(() => {
            element.style.transition = 'background-color 1s';
            const originalBg = element.style.backgroundColor;
            element.style.backgroundColor = '#fff3cd'; // Light yellow highlight
            setTimeout(() => {
              element.style.backgroundColor = originalBg;
            }, 2000);
          }, 100);
        }, 50);
      });
    };

    performScroll();
  }

  // Find the operation container that might need expanding
  function findOperationContainer(element) {
    // Look for parent elements that might be collapsible operation containers
    let parent = element.parentElement;

    while (parent && parent !== document.body) {
      // Look for HttpOperation class or other indicators of operation containers
      if (parent.classList.contains('HttpOperation') ||
        parent.querySelector('.HttpOperation') ||
        parent.querySelector('[data-testid*="operation"]')) {
        return parent;
      }
      parent = parent.parentElement;
    }

    return null;
  }

  // Expand operation container if collapsed (now simplified since we handle this in findAndScrollToOperation)
  function expandOperationContainer(container) {
    // This function is kept for compatibility but the main expansion logic
    // is now handled directly in findAndScrollToOperation using the native
    // Stoplight Elements structure
    console.log('expandOperationContainer called - expansion handled elsewhere');
  }

  // Handle hash changes for navigation
  function handleHashChange() {
    const hash = window.location.hash;
    if (hash.startsWith('#/operations/')) {
      const operationId = hash.replace('#/operations/', '');
      navigateToOperation(operationId);
    }
  }

  window.addEventListener('hashchange', handleHashChange);

  // Expose navigation function globally for testing
  window.navigateToOperation = navigateToOperation;

  // Expose injection function for debugging
  window.injectOperationIds = injectOperationIds;
  window.injectTagIds = injectTagIds;

  // Expose debug functions
  window.showOperationTagMap = function () {
    console.log('Operation → Tag Section mapping:');
    console.log('Total operations mapped:', Object.keys(operationToTagMap).length);
    if (Object.keys(operationToTagMap).length === 0) {
      console.log('No operations have been mapped yet. This could mean:');
      console.log('1. The page hasn\'t fully loaded');
      console.log('2. The spec hasn\'t been loaded yet');
      console.log('3. injectOperationIds() hasn\'t run yet');
      console.log('Try running: injectOperationIds() to manually trigger it');
    } else {
      Object.keys(operationToTagMap).forEach(opId => {
        const tagName = operationToTagMap[opId];
        console.log(`  ${opId} → ${tagName}`);
      });
    }
  };

  window.findOperationInTag = function (tagName) {
    const operations = [];
    Object.keys(operationToTagMap).forEach(opId => {
      const opTagName = operationToTagMap[opId];
      if (opTagName === tagName) {
        operations.push(opId);
      }
    });
    console.log(`Operations in "${tagName}" tag:`, operations);
    return operations;
  };

  // Handle initial hash on page load
  function handleInitialHash() {
    if (window.location.hash && window.location.hash.startsWith('#/operations/')) {
      const operationId = window.location.hash.replace('#/operations/', '');
      console.log(`Handling initial hash for operation: ${operationId}`);
      setTimeout(() => {
        navigateToOperation(operationId);
      }, 1500); // Give Stoplight Elements time to fully render
    }
  }

  if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', init);
  } else {
    init();
  }

  // Also handle initial hash after initialization
  setTimeout(handleInitialHash, 2000);
})();
