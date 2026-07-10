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
