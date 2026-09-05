#!/usr/bin/env bash
# Merges the current task branch into `main` and pushes. Call it from a task
# branch once the work item is finished and the page has been looked at in a
# browser.
#
# Counterpart to ship-to-int.sh in the imanio repo and ship-to-main.sh in
# imanio-admin. This repo has no `int` branch — `main` is the integration
# branch as well (declared that way in the dev shell's workspace.yaml).
#
# A push to main is a publish: GitHub Pages rebuilds
# https://meritondz.github.io/imanio-web/ from this branch within a minute.
set -euo pipefail
cd "$(dirname "$0")/.."

BRANCH=$(git branch --show-current)
if [[ "$BRANCH" == "main" ]]; then
  echo "❌ Call this from a task branch, not from '$BRANCH'."; exit 1
fi

if [[ -n "$(git status --porcelain)" ]]; then
  echo "❌ Working tree is not clean. Commit or stash first."; exit 1
fi

git checkout main
git pull --ff-only origin main
git merge --no-ff "$BRANCH" -m "merge $BRANCH into main"
git push origin main
echo "✅ '$BRANCH' merged into main and pushed."
echo "   GitHub Pages is rebuilding https://meritondz.github.io/imanio-web/"

# The branch now lives on in main. This workflow merges directly instead of
# going through PRs, so GitHub's "auto-delete head branch" never fires — clean
# up here, or the branch list only ever grows.
git branch -d "$BRANCH"
if git ls-remote --exit-code --heads origin "$BRANCH" >/dev/null 2>&1; then
  git push origin --delete "$BRANCH"
  echo "🧹 '$BRANCH' deleted (local + origin)."
else
  echo "🧹 '$BRANCH' deleted (local only — was never on origin)."
fi
