// Handle navigation for #/operations/ and #/schemas/ links when using router="memory"
document.addEventListener('DOMContentLoaded', function() {
  const apiElement = document.getElementById('api-docs');
  
  // // Intercept clicks on links with #/operations/ or #/schemas/
  // document.addEventListener('click', function(e) {
  //   const link = e.target.closest('a');
  //   if (link && link.getAttribute('href')) {
  //     const href = link.getAttribute('href');
  //     if (href.startsWith('#/operations/') || href.startsWith('#/schemas/')) {
  //       e.preventDefault();
  //       // Navigate the Stoplight Elements component to this route
  //       if (apiElement) {
  //         apiElement.setAttribute('router', 'memory');
  //         // Remove the # and set as the basePath for navigation
  //         const route = href.substring(1); // Remove leading #
  //         apiElement.setAttribute('basePath', route);
  //         // Force re-render by temporarily changing a property
  //         setTimeout(() => {
  //           window.location.hash = href;
  //           window.scrollTo({ top: 0, behavior: 'smooth' });
  //         }, 100);
  //       }
  //     }
  //   }
  // });
  
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

(function() {
  let operationMap = {};

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
          if (spec.paths) {
            for (const [path, methods] of Object.entries(spec.paths)) {
              for (const [method, op] of Object.entries(methods)) {
                if (op.operationId) {
                  // Normalized key: GET /accounts
                  const key = `${method.toUpperCase()} ${path}`;
                  operationMap[key] = op.operationId;
                }
              }
            }
          }
          console.log('Spec loaded. Map size:', Object.keys(operationMap).length);
          startObserver();
        })
        .catch(err => console.error('Failed to load spec for operationId injection', err));
  }

  function startObserver() {
    const observer = new MutationObserver((mutations) => {
      injectOperationIds();
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
          // 1. Create a wrapper
          const wrapper = document.createElement('span');
          wrapper.style.display = 'inline-flex';
          wrapper.style.alignItems = 'center';

          // 2. Operation ID Badge
          const idSpan = document.createElement('span');
          idSpan.textContent = ` [${operationId}]`;
          idSpan.style.fontSize = '12px';
          idSpan.style.color = '#555';
          idSpan.style.marginLeft = '12px';
          idSpan.style.fontFamily = 'monospace';
          idSpan.style.backgroundColor = 'rgba(0,0,0,0.05)';
          idSpan.style.padding = '2px 6px';
          idSpan.style.borderRadius = '4px';
          idSpan.style.border = '1px solid #ddd';
          idSpan.className = 'inserted-operation-id';
          idSpan.title = 'Operation ID';

          // 3. Anchor Link
          const anchorId = `/operations/${operationId}`;
          const anchorLink = document.createElement('a');
          anchorLink.href = `#${anchorId}`;
          anchorLink.textContent = '🔗';
          anchorLink.style.marginLeft = '8px';
          anchorLink.style.textDecoration = 'none';
          anchorLink.style.fontSize = '14px';
          anchorLink.style.cursor = 'pointer';
          anchorLink.title = `Permalink to ${operationId}`;
          
          wrapper.appendChild(idSpan);
          wrapper.appendChild(anchorLink);
          container.appendChild(wrapper);

          // 4. Set the ID on the container for scrolling
          // Only set it if the container doesn't have an ID or if we want to force it.
          // Since Stoplight might not put IDs here, let's try to set it safely or append an invisible anchor.
          if (!container.id) {
              container.id = anchorId;
          } else {
              // Append invisible anchor target
              const anchorTarget = document.createElement('a');
              anchorTarget.id = anchorId;
              anchorTarget.style.position = 'absolute';
              anchorTarget.style.top = '-100px'; // Offset for bad headers
              anchorTarget.style.visibility = 'hidden';
              container.style.position = 'relative'; // Ensure absolute positioning is relative to container
              container.appendChild(anchorTarget);
          }

          container.dataset.opIdInjected = 'true';

          // 5. Check if we need to scroll to this hash (if page loaded with this hash)
          if (window.location.hash === `#${anchorId}`) {
              setTimeout(() => {
                  container.scrollIntoView({ behavior: 'smooth', block: 'center' });
                  // Also highlight it briefly
                  container.style.transition = 'background-color 1s';
                  const originalBg = container.style.backgroundColor;
                  container.style.backgroundColor = '#fff3cd'; // Light yellow highlight
                  setTimeout(() => {
                      container.style.backgroundColor = originalBg;
                  }, 2000);
              }, 500);
          }
        }
      }
    });
  }

  // Handle hash changes for navigation
  function handleHashChange() {
    const hash = window.location.hash;
    if (hash.startsWith('#/operations/')) {
      const operationId = hash.replace('#/operations/', '');
      const anchorId = `/operations/${operationId}`;
      
      // Wait for Elements to render, then scroll to our anchor
      // Try multiple times with increasing delays to catch when the element appears
      let attempts = 0;
      const maxAttempts = 10;
      
      const tryScroll = () => {
        const targetElement = document.getElementById(anchorId);
        if (targetElement) {
          targetElement.scrollIntoView({ behavior: 'smooth', block: 'center' });
          
          // Highlight briefly
          targetElement.style.transition = 'background-color 1s';
          const originalBg = targetElement.style.backgroundColor;
          targetElement.style.backgroundColor = '#fff3cd'; // Light yellow highlight
          setTimeout(() => {
            targetElement.style.backgroundColor = originalBg;
          }, 2000);
        } else if (attempts < maxAttempts) {
          attempts++;
          setTimeout(tryScroll, 200 * attempts); // Exponential backoff
        }
      };
      
      setTimeout(tryScroll, 300); // Initial delay
    }
  }

  // Listen for hash changes
  window.addEventListener('hashchange', handleHashChange);

  if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', init);
  } else {
    init();
  }
})();
