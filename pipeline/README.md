# AI Docs Pipeline

Generates and maintains the `aidocs/` section of the Language Cloud API docs.

- **`aidocs/reference/`** — fully automated from the OpenAPI spec
- **`aidocs/guides/`** — human-reviewed, AI-assisted via VS Code Copilot


## How it works

When the API spec (`Public-API.v1.json`) changes, the pipeline regenerates all reference pages, including code examples from the .NET and Java SDKs.

When source documentation in `articles/LCPublicAPI/docs/` changes, the pipeline alerts you and provides the exact command to generate an AI prompt for updating the guides. You review and approve the output before it's committed.

All ai docs generation changes are committed to a dedicated branch.

---

## Release process

### AI docs pipeline

```powershell
# 1. Regenerate reference docs and flag any guide changes
.\pipeline\Invoke-AiDocsPipeline.ps1 -{params}

# 2. Generate the AI prompt for guides
.\pipeline\New-GuidesPrompt.ps1 -{params}

# 3. In VS Code Copilot chat (agent mode), type:
#    #_update-prompt.md  → send

# 4. Review .\aidocs\guides\

# 5. Refresh the master AI docs index
.\pipeline\Update-AiDocsIndex.ps1

# 6. Commit and push

```

#### Optional parameters (-{params})
```powershell
-All | [optional] | When supplied, regenerates everything, else only updates existing content.
```
---

### Trigger

**Actions → Generate AI Docs → Run workflow** in the GitHub UI.
