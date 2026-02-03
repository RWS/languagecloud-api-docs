# Trados Cloud Platform SDK - Migration Guide v25.x.x

## Executive Summary

The Trados Cloud Platform API SDK has transitioned from a "fat JAR" to a "light JAR" architecture, delivering faster downloads, improved dependency management, and better build performance. For most users, migration requires only a version update in your build configuration.


**What Changed:**
1. **Modernized Dependencies:** JUnit 4 → 5, Apache HttpClient 4 → 5, Commons Lang 2→3
2. **OpenAPI Generator:** Version 6.5.0 → 7.14.0 with enhanced nullability annotations
3. **Enhanced Features:** New `LCContext.executeInScope()` methods for improved tenant/trace context management
4. **Updated Tooling:** Latest versions of Jackson, Feign, and other core libraries

## Step-by-Step Migration Guide

### For Standard API Usage (Most Users):

If you're using the generated SDK classes like `ProjectApi`, `SourceFileApi`, etc., migration is straightforward:

1. Update SDK version to 25.x.x in your build configuration.
2. Run your build command to verify everything works.
3. Review and update your code for compatibility with the new OpenAPI Generator output (see the section [OpenAPI Generator & Generated Code Changes](#openapi-generator--generated-code-changes) below for details).
4. Your API calls should work as before, but review and resolve any compilation issues related to the above changes.

```java
// Your existing code continues to work
ProjectApi projectApi = languageCloudClientProvider.getProjectClient();
Project project = projectApi.createProject(projectCreateRequest, queryParams);
``` 
## Troubleshooting

**Most Common Issue**: Build fails after version update  
**Solution**: Run `mvn dependency:tree` to check for dependency conflicts

**Issue**: `ClassNotFoundException: feign.Client`  
**Solution**: Verify Feign dependencies: `mvn dependency:tree | grep feign`

**Issue**: `NoClassDefFoundError` for HTTP client classes  
**Solution**: Update imports from `org.apache.http` to `org.apache.hc.core5.http`

**Issue**: Commons Lang methods not found  
**Solution**: Update imports from `org.apache.commons.lang` to `org.apache.commons.lang3`

## Success Validation

**For Standard Users:**
1. Clean build: `mvn clean install` succeeds
2. API functionality works as before
3. Faster builds and smaller downloads

**For Advanced Users:**
- Run `mvn dependency:tree` - no conflicts shown
- Test application startup and core functionality

### Advanced Scenarios

<details>
<summary>Click here if you use direct dependency imports or custom configurations</summary>

#### Direct Dependency Usage:
- Update HttpClient imports: `org.apache.http` → `org.apache.hc.core5.http`
- Update Commons Lang imports: `org.apache.commons.lang` → `org.apache.commons.lang3`
- Use dependency exclusions if you encounter version conflicts

#### Custom Classpath Management:
1. Review current JAR collection and identify SDK dependencies
2. Ensure all transitive dependencies are included in classpath
3. Test application startup and core functionality
4. Consider migrating to Maven/Gradle for simplified dependency management

#### Test Framework Updates:
- **JUnit Migration**: JUnit 4 → JUnit 5 (Jupiter)
    - Update test annotations: `@Test` imports change from `org.junit.Test` → `org.junit.jupiter.api.Test`
    - Replace `@Before/@After` with `@BeforeEach/@AfterEach`
    - Update assertion imports: `org.junit.Assert` → `org.junit.jupiter.api.Assertions`
- **Mockito Updates**: Version 3.x → 5.x
    - Update imports if using `mockito-junit-jupiter` directly
    - Verify mock behavior with newer Mockito features

#### OpenAPI Generator & Generated Code Changes:
- **OpenAPI Generator**: Version 6.5.0 → 7.14.0 (major version upgrade)
- **Generated Code Improvements**: Enhanced code generation with:
    - **New Nullability Annotations**: `@javax.annotation.Nullable` and `@javax.annotation.Nonnull` annotations for better null safety
    - **Bean Validation Support**: Enhanced validation annotations for API parameters
    - **Improved Code Quality**: Updated Mustache templates producing cleaner, more maintainable generated code
    - **Better Method Naming**: Collection helper methods use improved naming conventions for better readability
    - **Enhanced Enum Handling**: Improved enum comparison and naming with configurable case sensitivity support
    - **Modernized Templates**: Generated classes follow current Java best practices

#### Benefits:
- Generated classes are easier to use and understand
- Better IDE support with improved nullability annotations
- More consistent naming conventions across generated code
- Enhanced type safety and validation

</details>

## Validation & Success Criteria

**For Standard Users:**
1. **Clean Build**: Your project builds successfully
2. **API Functionality**: SDK operations work as before - no code changes needed
3. **Performance**: Faster builds and smaller downloads

**Advanced Validation:**
- **Dependency Check**: `mvn dependency:tree` shows no conflicts
- **Custom Configurations**: Test application startup and functionality

## Reference: Key Dependencies

### High-Impact Dependencies (Most Likely to Affect You)

| Library             | Previous | New    | Notes                        |
|---------------------|----------|--------|------------------------------|
| Feign (HTTP Client) | 10.11    | 13.6   | Core SDK communication       |
| Jackson (JSON)      | 2.10.3   | 2.19.1 | API serialization            |
| Apache HttpClient   | 4.5.8    | 5.5    | HTTP transport               |
| JUnit (Tests)       | 4.13     | 5.13.2 | Test framework modernization |

<details>
<summary>View Complete Dependency List</summary>

**All Updated Dependencies:**

| GroupId                           | ArtifactId                | Previous Version | New Version | Impact     |
|-----------------------------------|---------------------------|------------------|-------------|------------|
| io.github.openfeign               | feign-core                | 10.11            | 13.6        | **High**   |
| io.github.openfeign               | feign-jackson             | 10.11            | 13.6        | **High**   |
| io.github.openfeign               | feign-slf4j               | 10.11            | 13.6        | **High**   |
| io.github.openfeign               | feign-form                | 3.8.0            | 13.6        | **High**   |
| io.github.openfeign               | feign-okhttp              | 10.11            | 13.6        | **High**   |
| com.fasterxml.jackson.core        | jackson-core              | 2.10.3           | 2.19.1      | **Medium** |
| com.fasterxml.jackson.core        | jackson-annotations       | 2.10.3           | 2.19.1      | **Medium** |
| com.fasterxml.jackson.core        | jackson-databind          | 2.10.3           | 2.19.1      | **Medium** |
| org.apache.httpcomponents.client5 | httpclient5               | 4.5.8*           | 5.5         | **Medium** |
| com.fasterxml.jackson.datatype    | jackson-datatype-jsr310   | 2.10.3           | 2.19.1      | Low        |
| com.fasterxml.jackson.datatype    | jackson-datatype-joda     | 2.0.4            | 2.19.1      | Low        |
| org.openapitools                  | jackson-databind-nullable | 0.2.1            | 0.2.6       | Low        |
| org.apache.commons                | commons-lang3             | 2.6*             | 3.18.0      | Low        |
| com.github.spotbugs               | spotbugs-annotations      | 3.0.2*           | 4.9.3       | Low        |
| javax.annotation                  | javax.annotation-api      | 1.0*             | 1.3.2       | Low        |
| org.projectlombok                 | lombok                    | RELEASE          | 1.18.38     | Low        |
| org.slf4j                         | slf4j-simple              | -                | 2.0.13      | Low        |

</details>

*Different groupId or artifactId in previous version

### Test Dependencies

| GroupId           | ArtifactId            | Previous Version | New Version | Impact   |
|-------------------|-----------------------|------------------|-------------|----------|
| org.junit.jupiter | junit-jupiter-engine  | 4.13*            | 5.13.2      | **High** |
| org.mockito       | mockito-junit-jupiter | 3.12.1*          | 5.18.0      | **High** |

*Different groupId or artifactId in previous version

### Most Important Changes

**Critical**: Maven Shade Plugin removed (enables fat→light JAR transition)  
**Modernization**: All dependencies updated to current versions  
**Code Quality**: OpenAPI Generator 6.5.0 → 7.14.0 with better nullability support


