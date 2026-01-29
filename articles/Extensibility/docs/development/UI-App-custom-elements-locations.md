---
stoplight-id: gwyrrbtyn4j2i
tags: [Development]
---

# Custom Elements and Locations

The platform supports the addition of various UI elements, including **buttons** (generic, link, and dropdown) and **panels** (generic, sidebar, and tab).
These elements can be incorporated into specific sections of the user interface in the **Customers, Inbox, Orders, Projects, Reports, and Vendors** areas.

<table>
  <thead>
    <tr>
      <th>Section</th>
      <th>View</th>
      <th>Location key</th>
      <th>Supported element types</th>
      <th>Default on-render selector keys</th>
      <th>Notes</th>
    </tr>
	</thead>
  <tbody>
    <tr>
      <td>Customers</td>
      <td>Customers list</td>
      <td>
        customers-list-tabpanel
        <img src="https://github.com/RWS/language-cloud-public-api-doc-resources/blob/main/extensibility/guides/developer/ui/customers-list-tabpanel.png?raw=true" alt="customers-list-tabpanel location">
      </td>
      <td>tab</td>
      <td></td>
      <td></td>
    </tr>
    <tr>
      <td rowspan="13">Inbox</td>
      <td>Tasks list</td>
      <td>
        tasks-list-tabpanel
        <img src="https://github.com/RWS/language-cloud-public-api-doc-resources/blob/main/extensibility/guides/developer/ui/tasks-list-tabpanel.png?raw=true" alt="tasks-list-tabpanel location">
      </td>
      <td>tab</td>
      <td></td>
      <td></td>
    </tr>
    <tr>
      <td rowspan="2">New tasks list</td>
      <td>
        new-tasks-list-sidebar
        <img src="https://github.com/RWS/language-cloud-public-api-doc-resources/blob/main/extensibility/guides/developer/ui/new-tasks-list-sidebar.png?raw=true" alt="new-tasks-list-sidebar location">
      </td>
      <td>sidebarBox</td>
      <td>inboxActiveTab, selectedNewTasks</td>
      <td></td>
    </tr>
    <tr>
      <td>
        new-tasks-list-toolbar
        <img src="https://github.com/RWS/language-cloud-public-api-doc-resources/blob/main/extensibility/guides/developer/ui/new-tasks-list-toolbar.png?raw=true" 
        alt="new-tasks-list-toolbar location">
      </td>
      <td>button</td>
      <td>inboxActiveTab, newTaskPreview</td>
      <td></td>
    </tr>
    <tr>
      <td rowspan="2">Active tasks list</td>
      <td>
		active-tasks-list-toolbar
        <img src="https://github.com/RWS/language-cloud-public-api-doc-resources/blob/main/extensibility/guides/developer/ui/active-tasks-list-toolbar.png?raw=true" alt="active-tasks-list-toolbar location">
      </td>
      <td>button</td>
      <td>inboxActiveTab, selectedActiveTasks</td>
      <td></td>
    </tr>
    <tr>
      <td>
		active-tasks-list-sidebar
        <img src="https://github.com/RWS/language-cloud-public-api-doc-resources/blob/main/extensibility/guides/developer/ui/active-tasks-list-sidebar.png?raw=true" alt="active-tasks-list-sidebar location">
	  </td>
      <td>sidebarBox</td>
      <td>inboxActiveTab, activeTaskPreview</td>
      <td></td>
    </tr>
    <tr>
      <td rowspan="2">Completed tasks list</td>
      <td>
		completed-tasks-list-toolbar
        <img src="https://github.com/RWS/language-cloud-public-api-doc-resources/blob/main/extensibility/guides/developer/ui/completed-tasks-list-toolbar.png?raw=true" alt=">completed-tasks-list-toolbar location">
	  </td>
      <td>button</td>
      <td>inboxActiveTab, selectedCompletedTasks</td>
      <td></td>
    </tr>
    <tr>
      <td>
		completed-tasks-list-sidebar
        <img src="https://github.com/RWS/language-cloud-public-api-doc-resources/blob/main/extensibility/guides/developer/ui/completed-tasks-list-sidebar.png?raw=true" alt="completed-tasks-list-sidebar location">
	  </td>
      <td>sidebarBox</td>
      <td>inboxActiveTab, completedTaskPreview</td>
      <td></td>
    </tr>
    <tr>
      <td rowspan="6">Task</td>
      <td>
		task-toolbar
        <img src="https://github.com/RWS/language-cloud-public-api-doc-resources/blob/main/extensibility/guides/developer/ui/task-toolbar.png?raw=true" alt="task-toolbar location">
	  </td>
      <td>button</td>
      <td>taskActiveTab, task</td>
      <td></td>
    </tr>
    <tr>
      <td>
		task-tabpanel
        <img src="https://github.com/RWS/language-cloud-public-api-doc-resources/blob/main/extensibility/guides/developer/ui/task-tabpanel.png?raw=true" alt="task-tabpanel location">
	  </td>
      <td>tab</td>
      <td>taskActiveTab, task	</td>
      <td></td>
    </tr>
    <tr>
      <td>
		task-sidebar
        <img src="https://github.com/RWS/language-cloud-public-api-doc-resources/blob/main/extensibility/guides/developer/ui/task-sidebar.png?raw=true" alt="task-sidebar location">
	  </td>
      <td>sidebarBox</td>
      <td>taskActiveTab, task</td>
      <td></td>
    </tr>
    <tr>
      <td>
		task-details-toolbar
        <img src="https://github.com/RWS/language-cloud-public-api-doc-resources/blob/main/extensibility/guides/developer/ui/task-details-toolbar.png?raw=true" alt="task-details-toolbar location">
	  </td>
      <td>button</td>
      <td>taskActiveTab, task	</td>
      <td></td>
    </tr>
    <tr>
      <td>
		task-details-main
        <img src="https://github.com/RWS/language-cloud-public-api-doc-resources/blob/main/extensibility/guides/developer/ui/task-details-main.png?raw=true" alt="task-details-main location">
	  </td>
      <td>panel</td>
      <td>taskActiveTab, task	</td>
      <td></td>
    </tr>
    <tr>
      <td>
		task-files-toolbar
        <img src="https://github.com/RWS/language-cloud-public-api-doc-resources/blob/main/extensibility/guides/developer/ui/task-files-toolbar.png?raw=true" alt="task-files-toolbar location">
	  </td>
      <td>button</td>
      <td>taskActiveTab, task</td>
      <td></td>
    </tr>
    <tr>
      <td>Orders</td>
      <td>Orders list</td>
      <td>
        orders-list-tabpanel
        <img src="https://github.com/RWS/language-cloud-public-api-doc-resources/blob/main/extensibility/guides/developer/ui/orders-list-tabpanel.png?raw=true" alt="orders-list-tabpanel location">
      </td>
      <td>tab</td>
      <td></td>
      <td></td>
    </tr>
    <tr>
      <td rowspan="12">Projects</td>
      <td rowspan="3">Projects list</td>
      <td>
        projects-list-tabpanel
        <img src="https://github.com/RWS/language-cloud-public-api-doc-resources/blob/main/extensibility/guides/developer/ui/projects-list-tabpanel.png?raw=true" alt="projects-list-tabpanel location">
      </td>
      <td>tab</td>
      <td></td>
      <td></td>
    </tr>
    <tr>
      <td>
		projects-list-toolbar
        <img src="https://github.com/RWS/language-cloud-public-api-doc-resources/blob/main/extensibility/guides/developer/ui/projects-list-toolbar.png?raw=true" alt="projects-list-toolbar location">
	  </td>
      <td>button</td>
      <td>selectedProjects</td>
      <td></td>
    </tr>
    <tr>
      <td>
		project-details-dashboard-sidebar *
        <img src="https://github.com/RWS/language-cloud-public-api-doc-resources/blob/main/extensibility/guides/developer/ui/project-details-dashboard-sidebar.png?raw=true" alt="project-details-dashboard-sidebar location">
	  </td>
      <td>sidebarBox</td>
      <td>projectDetailsActiveTab, projectDetails</td>
      <td>element visible in two views</td>
    </tr>
    <tr>
      <td rowspan="9">Project</td>
      <td>
		project-details-toolbar
        <img src="https://github.com/RWS/language-cloud-public-api-doc-resources/blob/main/extensibility/guides/developer/ui/project-details-toolbar.png?raw=true" alt="project-details-toolbar location">
	  </td>
      <td>button</td>
      <td>projectDetailsActiveTab, projectDetails</td>
      <td></td>
    </tr>
    <tr>
      <td>
		project-details-tabpanel
        <img src="https://github.com/RWS/language-cloud-public-api-doc-resources/blob/main/extensibility/guides/developer/ui/project-details-tabpanel.png?raw=true" alt="project-details-tabpanel location">
	  </td>
      <td>tab</td>
      <td>projectDetailsActiveTab, projectDetails</td>
      <td></td>
    </tr>
    <tr>
      <td>
		project-details-dashboard-toolbar
        <img src="https://github.com/RWS/language-cloud-public-api-doc-resources/blob/main/extensibility/guides/developer/ui/project-details-dashboard-toolbar.png?raw=true" alt="project-details-dashboard-toolbar location">
	  </td>
      <td>button</td>
      <td>projectDetailsActiveTab, projectDetails</td>
      <td></td>
    </tr>
    <tr>
      <td>
		project-details-dashboard-main
        <img src="https://github.com/RWS/language-cloud-public-api-doc-resources/blob/main/extensibility/guides/developer/ui/project-details-dashboard-main.png?raw=true" alt="project-details-dashboard-main location">
	  </td>
      <td>panel</td>
      <td>projectDetailsActiveTab, projectDetails</td>
      <td></td>
    </tr>
    <tr>
      <td>
		project-details-dashboard-sidebar *
        <img src="https://github.com/RWS/language-cloud-public-api-doc-resources/blob/main/extensibility/guides/developer/ui/project-details-dashboard-sidebar.png?raw=true" alt="project-details-dashboard-sidebar location">
	  </td>
      <td>sidebarBox</td>
      <td>projectDetailsActiveTab, projectDetails</td>
      <td>element visible in two views</td>
      </tr>
    <tr>
      <td>
		project-details-stages-toolbar
        <img src="https://github.com/RWS/language-cloud-public-api-doc-resources/blob/main/extensibility/guides/developer/ui/project-details-stages-toolbar.png?raw=true" alt="project-details-stages-toolbar location">
	  </td>
      <td>button</td>
      <td>projectDetailsActiveTab, projectDetails, projectStages</td>
      <td></td>
    </tr>
    <tr>
      <td>
		project-details-files-toolbar
        <img src="https://github.com/RWS/language-cloud-public-api-doc-resources/blob/main/extensibility/guides/developer/ui/project-details-files-toolbar.png?raw=true" alt="project-details-files-toolbar location">
	  </td>
      <td>button</td>
      <td>projectDetailsActiveTab, projectDetails, projectFiles</td>
      <td></td>
    </tr>
    <tr>
      <td>
		project-details-task-history-toolbar
        <img src="https://github.com/RWS/language-cloud-public-api-doc-resources/blob/main/extensibility/guides/developer/ui/project-details-task-history-toolbar.png?raw=true" alt="project-details-task-history-toolbar location">
	  </td>
      <td>button</td>
      <td>projectDetailsActiveTab, projectDetails, projectTaskHistory</td>
      <td></td>
    </tr>
    <tr>
      <td>
		project-details-task-history-sidebar
        <img src="https://github.com/RWS/language-cloud-public-api-doc-resources/blob/main/extensibility/guides/developer/ui/project-details-task-history-sidebar.png?raw=true" alt="project-details-task-history-sidebar location">
	  </td>
      <td>sidebarBox</td>
      <td>projectDetailsActiveTab, projectDetails, projectTaskHistory</td>
      <td></td>
    </tr>
    <tr>
      <td>Reports</td>
      <td>Reports list</td>
      <td>
        reports-list-tabpanel
        <img src="https://github.com/RWS/language-cloud-public-api-doc-resources/blob/main/extensibility/guides/developer/ui/reports-list-tabpanel.png?raw=true" alt="reports-list-tabpanel location">
      </td>
      <td>tab</td>
      <td></td>
      <td></td>
    </tr>
    <tr>
      <td>Vendors</td>
      <td>Vendors list</td>
      <td>
        vendors-list-tabpanel
        <img src="https://github.com/RWS/language-cloud-public-api-doc-resources/blob/main/extensibility/guides/developer/ui/vendors-list-tabpanel.png?raw=true" alt="vendors-list-tabpanel location">
      </td>
      <td>tab</td>
      <td></td>
      <td></td>
    </tr>
  </tbody>
</table>

\* The `sidebarBox` element targeting the `project-details-dashboard-sidebar` location key is also displayed in the Projects list view when a project in the list is selected.
