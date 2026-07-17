# GitHub Actions CI/CD Pipeline

An automated CI workflow that builds and validates the Dockerized Web Application on every push, using GitHub Actions.

## What it does

On every push (or pull request) that touches files in `dockerized-web-app/`, GitHub Actions automatically:

1. Checks out the repository code
2. Builds the Docker image from the project's Dockerfile
3. Runs a container from the freshly built image
4. Sends a request to the running container and verifies the expected page content is returned
5. Tears down the test container, regardless of whether the check passed or failed

This catches broken builds or misconfigured containers automatically, before they'd ever reach a real deployment.

## Workflow file

Located at [`.github/workflows/docker-ci.yml`](../.github/workflows/docker-ci.yml).

## Key Learnings

- **Path filtering**: Using `paths:` in the trigger config scopes the workflow to only run when relevant files change, avoiding wasted CI runs on unrelated commits.
- **Ephemeral runners**: Each workflow run happens on a fresh, temporary virtual machine — nothing persists between runs, which is why the image is rebuilt from scratch every time rather than reused.
- **Verification, not just building**: A successful `docker build` doesn't guarantee the app actually works — this pipeline explicitly `curl`s the running container to confirm real content is served, not just that the image compiled.
## CD Extension

The pipeline was extended beyond CI to full CD:

1. **`push-image`** — after tests pass, the image is built and pushed to Docker Hub
2. **`deploy`** — GitHub Actions SSHes into the EC2 instance (using a dedicated deploy key, separate from personal access credentials) and redeploys the container with the newly pushed image

This means a `git push` alone now takes code all the way to a running, updated container on the live instance — no manual steps.

### Key Learnings
- **Path filters affect all triggers**: a `paths:` filter blocks workflow runs on *any* trigger type, including `workflow_dispatch`, if the changed files fall outside that path — worth remembering when debugging "why didn't this run?"
- **`if:` conditions must account for every trigger type used**: a condition checking only `github.event_name == 'push'` silently skips jobs on manual runs unless explicitly extended.
- **Identical errors in different environments can have unrelated causes**: the same Docker Hub auth error appeared both locally and in CI, but the real cause was a duplicated command, not the credentials or secrets themselves — reproducing an error outside the CI runner is a fast way to isolate script bugs from environment/config bugs.
