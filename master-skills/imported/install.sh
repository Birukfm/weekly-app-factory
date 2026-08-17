#!/usr/bin/env bash
# Clone the 10 factory skill sources into master-skills/imported/.
# Anthropic skills are pointers only (already at repo root).
# weekly-app-factory is authored in ../playbook/ (source 10).
set -euo pipefail

ROOT="$(cd "$(dirname "$0")" && pwd)"
TMP="$(mktemp -d)"
trap 'rm -rf "$TMP"' EXIT

clone_sparse() {
  local repo="$1"
  local dest="$2"
  rm -rf "$dest"
  mkdir -p "$dest"
  git clone --depth 1 --filter=blob:none "https://github.com/${repo}.git" "$dest"
}

copy_skill() {
  local src="$1"
  local dest="$2"
  if [[ ! -d "$src" ]]; then
    echo "WARN: missing $src" >&2
    return 0
  fi
  mkdir -p "$(dirname "$dest")"
  rm -rf "$dest"
  cp -R "$src" "$dest"
}

echo "==> superpowers (selected skills)"
clone_sparse "obra/superpowers" "$TMP/superpowers"
rm -rf "$ROOT/superpowers"
mkdir -p "$ROOT/superpowers"
for skill in brainstorming writing-plans executing-plans verification-before-completion systematic-debugging; do
  copy_skill "$TMP/superpowers/skills/${skill}" "$ROOT/superpowers/${skill}"
done

echo "==> vercel-labs/agent-skills (web-design-guidelines + react-native negative control)"
clone_sparse "vercel-labs/agent-skills" "$TMP/vercel"
rm -rf "$ROOT/vercel"
mkdir -p "$ROOT/vercel"
# Layouts vary; copy any matching folder name.
while IFS= read -r -d '' path; do
  name="$(basename "$(dirname "$path")")"
  case "$name" in
    web-design-guidelines|react-native-guidelines|react-native-skills|vercel-react-native-skills)
      copy_skill "$(dirname "$path")" "$ROOT/vercel/${name}"
      ;;
  esac
done < <(find "$TMP/vercel" -name SKILL.md -print0)

echo "==> flutter/agent-plugins"
clone_sparse "flutter/agent-plugins" "$TMP/flutter"
rm -rf "$ROOT/flutter"
mkdir -p "$ROOT/flutter"
if [[ -d "$TMP/flutter/skills" ]]; then
  cp -R "$TMP/flutter/skills/." "$ROOT/flutter/"
else
  while IFS= read -r -d '' path; do
    copy_skill "$(dirname "$path")" "$ROOT/flutter/$(basename "$(dirname "$path")")"
  done < <(find "$TMP/flutter" -name SKILL.md -print0)
fi

echo "==> dart-lang/skills"
clone_sparse "dart-lang/skills" "$TMP/dart"
rm -rf "$ROOT/dart"
mkdir -p "$ROOT/dart"
if [[ -d "$TMP/dart/skills" ]]; then
  cp -R "$TMP/dart/skills/." "$ROOT/dart/"
else
  while IFS= read -r -d '' path; do
    copy_skill "$(dirname "$path")" "$ROOT/dart/$(basename "$(dirname "$path")")"
  done < <(find "$TMP/dart" -name SKILL.md -print0)
fi

echo "==> android/skills"
clone_sparse "android/skills" "$TMP/android"
rm -rf "$ROOT/android"
mkdir -p "$ROOT/android"
if [[ -d "$TMP/android/skills" ]]; then
  cp -R "$TMP/android/skills/." "$ROOT/android/"
else
  while IFS= read -r -d '' path; do
    copy_skill "$(dirname "$path")" "$ROOT/android/$(basename "$(dirname "$path")")"
  done < <(find "$TMP/android" -name SKILL.md -print0)
fi

echo "==> conorluddy/ios-simulator-skill"
clone_sparse "conorluddy/ios-simulator-skill" "$TMP/ios-simulator"
rm -rf "$ROOT/ios-simulator"
mkdir -p "$ROOT/ios-simulator"
if [[ -f "$TMP/ios-simulator/SKILL.md" ]]; then
  cp -R "$TMP/ios-simulator/." "$ROOT/ios-simulator/"
  rm -rf "$ROOT/ios-simulator/.git"
else
  while IFS= read -r -d '' path; do
    copy_skill "$(dirname "$path")" "$ROOT/ios-simulator/$(basename "$(dirname "$path")")"
  done < <(find "$TMP/ios-simulator" -name SKILL.md -print0)
fi

echo "==> Expo skills (negative control; likely archive after Week 1)"
rm -rf "$ROOT/expo"
mkdir -p "$ROOT/expo"
expo_ok=0
for repo in "expo/skills" "expo/agent-skills" "expo/expo"; do
  if git clone --depth 1 --filter=blob:none "https://github.com/${repo}.git" "$TMP/expo-${repo##*/}" 2>/dev/null; then
    count="$(find "$TMP/expo-${repo##*/}" -name SKILL.md | wc -l | tr -d ' ')"
    if [[ "$count" != "0" ]]; then
      while IFS= read -r -d '' path; do
        copy_skill "$(dirname "$path")" "$ROOT/expo/$(basename "$(dirname "$path")")"
      done < <(find "$TMP/expo-${repo##*/}" -name SKILL.md -print0)
      echo "    cloned $repo ($count skills)"
      expo_ok=1
      break
    fi
  fi
done
if [[ "$expo_ok" -eq 0 ]]; then
  echo "    Expo GitHub skill repo not found; trying npx skills add expo/skills"
  if npx --yes skills add expo/skills --list -y >/tmp/expo-skills-list.txt 2>/dev/null; then
    npx --yes skills add expo/skills --skill '*' --agent universal --copy -y || true
  fi
  printf '%s\n' "Expo skill clone failed. Install later with: npx skills add expo/skills --skill '*' --agent universal -y" > "$ROOT/expo/README.md"
fi

echo "==> shipflutter/skills (appdist)"
clone_sparse "shipflutter/skills" "$TMP/ship" || true
rm -rf "$ROOT/ship"
mkdir -p "$ROOT/ship"
if [[ -d "$TMP/ship" ]]; then
  if [[ -d "$TMP/ship/skills/appdist" ]]; then
    copy_skill "$TMP/ship/skills/appdist" "$ROOT/ship/appdist"
  elif [[ -d "$TMP/ship/appdist" ]]; then
    copy_skill "$TMP/ship/appdist" "$ROOT/ship/appdist"
  else
    while IFS= read -r -d '' path; do
      name="$(basename "$(dirname "$path")")"
      if [[ "$name" == "appdist" ]]; then
        copy_skill "$(dirname "$path")" "$ROOT/ship/appdist"
      fi
    done < <(find "$TMP/ship" -name SKILL.md -print0)
  fi
fi
if [[ ! -d "$ROOT/ship/appdist" ]]; then
  printf '%s\n' "appdist not found. Fallback: use Saturday section in weekly-app-factory. Retry: npx skills add shipflutter/skills --skill appdist --agent universal -y" > "$ROOT/ship/README.md"
fi

echo "==> anthropic: pointers only (see anthropic/README.md)"
echo "==> weekly-app-factory: authored at ../playbook/weekly-app-factory/"

echo
echo "Imported trees:"
find "$ROOT" -name SKILL.md | sed "s|^$ROOT/||" | sort
echo "Done."
