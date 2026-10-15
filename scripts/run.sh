#!/bin/bash
# Run the scaffolding in a fresh working directory, with the action's virtualenv first in PATH.
# Expects the action inputs as INPUT_* environment variables and the virtualenv path as the first argument.

set -euo pipefail

readonly venv="${1:?virtualenv path required}"
action_path="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
readonly action_path

workdir="$(mktemp -d "${RUNNER_TEMP:-/tmp}/cookiecutter.XXXXXX")"
trap 'rm -rf "$workdir"' EXIT
cd "$workdir"

PATH="$venv/bin:$PATH" "$action_path/entrypoint.sh"
