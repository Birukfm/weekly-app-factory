# Master skills

Operating system for the Weekly App Factory. Skills here **structure** the week. They do not replace the idea, the keyword, or shipping.

Human entry point: this file. Agent entry point: [playbook/weekly-app-factory/SKILL.md](playbook/weekly-app-factory/SKILL.md).

## How to run a week

1. Open Cursor in this repo (or in the app repo with this folder available).
2. Say: `Run week N for idea: <keyword>. Use weekly-app-factory.`
3. Provide the idea. The agent does not invent a new category mid-week.
4. Load **one extra skill per day**. Do not attach the whole catalog.

| Day | Extra skills | Done when |
|-----|--------------|-----------|
| Mon | `domain-name-brainstormer`, `content-research-writer` | Go/no-go, name, hook |
| Tue | official Flutter + Dart | Boilerplate cloned, IAP IDs created |
| Wed | Flutter architecture/routing, `verification-before-completion` | Core feature compiles |
| Thu | `frontend-design`, `using-ui-stack`, `theme-factory`, `image-enhancer` | Icon + screenshots |
| Fri | `content-research-writer` | Both stores submitted |
| Sat | `ios-simulator-skill` if needed | TestFlight + Play internal on a phone |
| Sun | `competitive-ads-extractor` only if live | 5 videos + 5-line log |

Sunday definition of done: installable builds, listing filled, videos filmed. Production review can lag.

## Folder layout

```
master-skills/
  README.md                 this file
  ASSESSMENT.md             scoring rubric (fill after Week 1)
  local-links.md            skills already in this catalog
  playbook/
    weekly-app-factory/     the operating skill
  imported/                 third-party skills (see imported/SOURCES.md)
    flutter/
    dart/
    android/
    superpowers/
    vercel/
    anthropic/              pointers; originals live at repo root
    ios-simulator/
    expo/                   negative control (wrong stack)
    ship/
app-boilerplate/            Flutter shell (repo root)
tools/respectaso/           RespectASO clone (gitignored; ./tools/clone-respectaso.sh)
tools/research_keyword.py   Monday ASO CLI
```

## Import

Imported copies are local-only (gitignored) so this catalog does not vendor other licenses wholesale. Re-run from [imported/SOURCES.md](imported/SOURCES.md):

```bash
# from repo root
./master-skills/imported/install.sh
```

## Assessment

After Week 1, score every imported skill with [ASSESSMENT.md](ASSESSMENT.md). Keep official Flutter/Dart/Android even if stars are under 10k. Cut Expo/RN if they never fired. Cut duplicates of `frontend-design` / `using-ui-stack` / `theme-factory`.

## $100/month

About 4 yearly subscribers or ~25 weekly subscribers after store cut. Month 1 is four ship loops. Revenue lags. Do not buy ads until a video clearly works and there is cash to lose.
