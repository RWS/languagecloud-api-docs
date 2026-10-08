# AI Docs Pipeline

Generates and maintains the `aidocs/` section of the Trados API docs.

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
.\scripts\ai-docs-scripts\Invoke-AiDocsPipeline.ps1 -{params}

# 2. Generate the AI prompt for guides
.\scripts\ai-docs-scripts\New-GuidesPrompt.ps1 -{params}

# 3. Manual step in VS Code: open Copilot Chat in agent mode and type:
#    #_update-prompt.md  → send
#    (or drag the generated _update-prompt.md file into the chat input)
#
#    This is a human/local action. GitHub Actions cannot open VS Code or Copilot Chat.
#    The automation stops after pushing the AI docs review branch. A person opens the PR.

# 4. Review and accept the generated guide updates in .\aidocs\guides\

# 5. Refresh the master AI docs index
.\scripts\ai-docs-scripts\Update-AiDocsIndex.ps1

# 6. Commit and push

```

### Review-branch workflow

For release integration, the repository can also create a dedicated AI docs review branch. A person then finishes the guides locally, opens the pull request and merges it into main.

```powershell
# Run from GitHub Actions
# Actions → Generate AI Docs → Run workflow
#
# Inputs:
#   base_branch   = main
#   release_name  = YYYY.MM.RXX or a custom label
#   force_regenerate = true/false
```

This workflow:
- creates a branch such as `ai-docs/2026.10.1`
- runs the AI docs generation scripts against the final release state
- pushes the generated `aidocs/` output to that branch
- writes a next-steps summary on the workflow run page, with a link to this guide and a ready-made "create PR" link
- does **not** open a PR and does **not** merge to `main`. Both are done by a person.

> Important: the Copilot/agent step is still a manual local action in VS Code. A GitHub Action cannot launch the VS Code Copilot chat experience for a person.

### Reviewer guide (step by step, no technical knowledge needed)

Do this after the workflow run has finished. Do the steps in order and do not skip any.

1. **Get the branch name.** On GitHub open Actions > the finished **Generate AI Docs** run. The summary at the bottom shows the branch name (it starts with `ai-docs/`).
2. **Open VS Code** and open the `languagecloud-api-docs` folder (File > Open Folder).
3. **Switch to the branch.** Click the branch name at the bottom-left of VS Code, then pick `origin/ai-docs/...` (the name from step 1).
4. **Open the terminal.** In the VS Code menu choose Terminal > New Terminal. A panel opens at the bottom.
5. **Create the AI prompt.** Copy this line into the terminal and press Enter:
   ```powershell
   .\scripts\ai-docs-scripts\New-GuidesPrompt.ps1 -All
   ```
   You should see `Prompt written to: ...\_update-prompt.md` in green.
6. **Run the AI agent.**
   1. Open Copilot Chat (chat icon at the top of VS Code, or press Ctrl+Alt+I).
   2. In the chat box, make sure the mode says **Agent** (use the dropdown if it does not).
   3. Type `#_update-prompt.md` and press Enter.
   4. Wait until Copilot says it is finished (this can take several minutes), then click **Keep** to accept the changes.
7. **Rebuild the indexes.** Copy these two lines into the terminal, one at a time, pressing Enter after each:
   ```powershell
   .\scripts\ai-docs-scripts\Update-GuidesIndex.ps1
   .\scripts\ai-docs-scripts\Update-AiDocsIndex.ps1
   ```
   Each prints `Updated` (green) or `Unchanged` (grey). Both are fine. A red message means something went wrong: stop and ask the docs team.
8. **Save your work.** Open Source Control (branch icon on the left), type a short message such as `docs: update AI guides`, click **Commit**, then **Sync Changes**.
9. **Open the PR yourself.** Go back to the workflow run summary and click **Create PR into main** (or on GitHub click **Compare & pull request** for your branch). Read through the changed files and ask a teammate to approve it. The merge to `main` is always done by a person, never automatically.

#### Optional parameters (-{params})
```powershell
-All | [optional] | When supplied, regenerates everything, else only updates existing content.
```
---

### Trigger

**Actions → Generate AI Docs → Run workflow** in the GitHub UI.
