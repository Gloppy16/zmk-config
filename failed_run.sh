
#!/usr/bin/env bash
set -euo pipefail

REPO="${REPO:-Gloppy16/zmk-config}"
RUN_ID="${RUN_ID:-$(gh run list -R "$REPO" \
  --status failure \
  --limit 1 \
  --json databaseId \
  --jq '.[0].databaseId')}"

if [[ -z "$RUN_ID" ]]; then
  echo "No failed runs found for $REPO" >&2
  exit 1
fi

echo "Run: $RUN_ID"
gh run view "$RUN_ID" -R "$REPO" --log-failed
