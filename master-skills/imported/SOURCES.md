# Imported skill sources

Ten sources from the playbook. Copies under these folders are gitignored. This file and `install.sh` are committed.

| # | Source | Why | Stars (approx) | Destination |
|---|--------|-----|----------------|-------------|
| 1 | [obra/superpowers](https://github.com/obra/superpowers) | Methodology. Keep only five skills (see install.sh). Drop TDD-for-everything. | 273k | `superpowers/` |
| 2 | [anthropics/skills](https://github.com/anthropics/skills) | Design + ads + skill-creator. Already vendored at repo root. | 170k | `anthropic/README.md` pointers |
| 3 | [vercel-labs/agent-skills](https://github.com/vercel-labs/agent-skills) | `web-design-guidelines` keep. `react-native-guidelines` is a negative control. | 30k | `vercel/` |
| 4 | [flutter/agent-plugins](https://github.com/flutter/agent-plugins) | Official Flutter 2026. Must import despite <10k. | 2.8k | `flutter/` |
| 5 | [dart-lang/skills](https://github.com/dart-lang/skills) | Official Dart. Must import. | 0.4k | `dart/` |
| 6 | [android/skills](https://github.com/android/skills) | Play-era Android (edge-to-edge, AGP). Must import. | 6.8k | `android/` |
| 7 | [conorluddy/ios-simulator-skill](https://github.com/conorluddy/ios-simulator-skill) | Agent taps Simulator instead of guessing. | n/a | `ios-simulator/` |
| 8 | Expo official skills | Import then likely reject. Evidence, not vibes. | n/a | `expo/` |
| 9 | Ship/distribution (`niceprompt/shipflutter-skills` appdist or fallback) | TestFlight + Play internal. If poor, use playbook Saturday section. | n/a | `ship/` |
| 10 | [weekly-app-factory](../playbook/weekly-app-factory/SKILL.md) | Custom operating skill. Not imported; authored in `playbook/`. | 0 | `../playbook/` |

A hard 10k-star filter does not yield ten mobile skill repos. Official Flutter/Dart/Android are included on purpose.

Re-run:

```bash
chmod +x master-skills/imported/install.sh
./master-skills/imported/install.sh
```
