#!/bin/bash
# Create the virtualenv holding the pinned Python requirements and expose its path as the `venv` step output.

set -euo pipefail

action_path="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
readonly action_path
readonly venv="${RUNNER_TEMP:-/tmp}/gh-action-cookiecutter-venv"

for tool in git curl jq; do
  if ! command -v "$tool" >/dev/null; then
    echo "::error::$tool is required on the runner" >&2
    exit 1
  fi
done

python3 -m venv "$venv"
"$venv/bin/pip" install --disable-pip-version-check --no-cache-dir --only-binary :all: \
  --requirement "$action_path/requirements.txt"

echo "venv=$venv" >>"$GITHUB_OUTPUT"
