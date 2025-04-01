# Service users and custom applications

Service users are special users created when developing custom applications that integrate with the Trados Cloud Platform API.

Service users:
- Are non-human users
- Don’t have login credentials 
- Can only access Trados Cloud Platform via the Trados Cloud Platform API

### Who can create service users?

Service users are managed by administrators within a Trados Cloud Platform account. Administrators add service users to one or more groups. Once service users become part of a group, they automatically get a role, namely the group role which is associated with a predefined set of permissions. Service users access resources based on the permissions associated with the group (role) they belong to.

### How are service users assigned to custom applications?

When Trados Cloud Platform administrators create a custom application from the Trados UI, they assign one service user per application.

### How does the authentication process of service users work?

Whenever a third-party client authenticates with the application credentials, calls against the Trados Cloud Platform API will assume the identity of the service user within the platform for the purpose of authorizing access to data.
