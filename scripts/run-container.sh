#!/bin/bash
# Run the scaffolding image built by the action.
# Expects the action inputs as INPUT_* environment variables and the image tag as the first argument.

set -euo pipefail

readonly image="${1:?image tag required}"

# The container user does not map to the runner user on every Docker setup (e.g. rootless),
# so the working directory is world-writable and the container writes its outputs inside it.
workdir="$(mktemp -d "${RUNNER_TEMP:-/tmp}/cookiecutter.XXXXXX")"
chmod 0777 "$workdir"
trap 'rm -rf "$workdir" 2>/dev/null || true' EXIT

# Forward the inputs by name so that their values never appear on the command line
env_args=()
while IFS= read -r name; do
  env_args+=(--env "$name")
done < <(compgen -e | grep '^INPUT_' || true)

docker run --rm \
  --env HOME=/tmp \
  --env GITHUB_OUTPUT=/github/workspace/.outputs \
  "${env_args[@]}" \
  --volume "$workdir:/github/workspace" \
  --workdir /github/workspace \
  "$image"

# Only the expected output is passed on to the step
repo_url="$(grep -m1 '^repoURL=' "$workdir/.outputs" | tr -d '\r' || true)"
if [[ -n "$repo_url" ]]; then
  echo "$repo_url" >>"$GITHUB_OUTPUT"
fi
