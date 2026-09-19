# Changesets Directory

This directory stores intent-to-deploy declarations for Pull Requests in the Bona Loko monorepo.

## How it Works
1. When making changes to any deployable application (e.g., `web-app/**`, `content/**`), generate a changeset using:
   ```bash
   npm run changeset
   ```
2. The interactive script will detect modified applications, prompt for the version bump type (`patch`, `minor`, `major`), and create a new markdown file in this directory.
3. In CI, your PR will be validated against `deploy-targets.json`:
   - If files in an application directory changed, its tag **must** be present in the changeset.
   - If no files changed for an application, its tag **must not** be present in the changeset.
4. When your PR is merged into `main`, GitHub Actions automatically:
   - Increments application versions.
   - Generates and pushes git tags on the merge commit (e.g. `web-app/v1.0.1`).
   - Deploys the application (e.g. Nuxt 3 to Cloudflare Pages).
   - Cleans up consumed changesets.
