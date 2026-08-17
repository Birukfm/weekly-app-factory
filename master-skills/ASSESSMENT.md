# Skill assessment rubric

Fill this after Week 1 (first app shipped), not before. Stars are a weak signal for agent skills: the format is new (2025–2026). Official 2026 mobile sources beat star count.

Score 0–2 on each criterion. Keep if total ≥ 8 or if it prevented a store rejection. Archive if 0 on "wrong stack" or "never invoked".

| Criterion | 0 | 1 | 2 |
|-----------|---|---|---|
| Invoked without being forced | Never | Once, when named | Agent picked it from the task |
| Prevented a real bug | No | Minor | IAP, permission, edge-to-edge, or review issue |
| One job, SKILL.md ≲ 500 lines | Essay / kitchen sink | Usable but bloated | Progressive disclosure, one job |
| 2026 source of truth | Blog-grade / stale | Community, maintained | Official Flutter, Dart, or Android |
| Not a duplicate | Clone of another keep | Overlaps but adds a rule | Unique |
| Right stack | Expo/RN/web-only | Partial Flutter | Flutter + store ship |

Wrong stack (Expo, React Native) → archive even with high stars, unless a specific rule transferred (then extract that rule into `weekly-app-factory` and drop the rest).

Duplicate design trio (`frontend-design`, `using-ui-stack`, `theme-factory`): keep the two Cursor skills for UI generation; keep `theme-factory` only if Thursday still needs palette packs. Drop the weaker one.

## Scorecard (fill after Week 1)

| Source | Skill | Stars (repo) | Invoked | Bug | Concise | Official | Unique | Stack | Total | Keep / cut / archive |
|--------|-------|--------------|---------|-----|---------|----------|--------|-------|-------|----------------------|
| playbook | weekly-app-factory | 0 | | | | | | | | |
| flutter/agent-plugins | (list) | ~2.8k | | | | | | | | |
| dart-lang/skills | (list) | ~0.4k | | | | | | | | |
| android/skills | (list) | ~6.8k | | | | | | | | |
| obra/superpowers | brainstorming | ~273k | | | | | | | | |
| obra/superpowers | writing-plans | | | | | | | | | |
| obra/superpowers | executing-plans | | | | | | | | | |
| obra/superpowers | verification-before-completion | | | | | | | | | |
| obra/superpowers | systematic-debugging | | | | | | | | | |
| anthropics / local | theme-factory | ~170k | | | | | | | | |
| anthropics / local | content-research-writer | | | | | | | | | |
| anthropics / local | competitive-ads-extractor | | | | | | | | | |
| anthropics / local | domain-name-brainstormer | | | | | | | | | |
| anthropics / local | image-enhancer | | | | | | | | | |
| vercel-labs | web-design-guidelines | ~30k | | | | | | | | |
| vercel-labs | react-native-guidelines | ~30k | | | | | | | | expected archive |
| conorluddy | ios-simulator-skill | | | | | | | | | |
| expo | (list) | | | | | | | | | expected archive |
| shipflutter / appdist | (list) | | | | | | | | | |
| Cursor | frontend-design | n/a | | | | | | | | |
| Cursor | using-ui-stack | n/a | | | | | | | | |

## Decision log

After scoring, write three bullets:

- Kept because:
- Cut because:
- Extracted a single rule into weekly-app-factory:
