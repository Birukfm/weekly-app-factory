#!/usr/bin/env bash
# Clone RespectASO into tools/respectaso and create a local venv.
set -euo pipefail
ROOT="$(cd "$(dirname "$0")" && pwd)"
DEST="$ROOT/respectaso"
VENV="$ROOT/.venv"
REPO="https://github.com/respectlytics/respectaso.git"
if [[ -d "$DEST/.git" ]]; then
  echo "RespectASO already cloned at $DEST"
  git -C "$DEST" pull --ff-only || true
else
  if [[ -d "$DEST" ]]; then
    echo "Removing incomplete $DEST"
    rm -rf "$DEST"
  fi
  git clone --depth 1 "$REPO" "$DEST"
  echo "Cloned to $DEST"
fi
if [[ ! -x "$VENV/bin/python" ]]; then
  python3 -m venv "$VENV"
fi
"$VENV/bin/pip" install -q -r "$ROOT/requirements.txt"
echo "Monday command: $VENV/bin/python $ROOT/research_keyword.py \"your keyword\""
