---
name: weekly-app-factory
description: Runs a Monday-Sunday loop to ship one searchable, monetizable Flutter app (iOS + Android) using Max's keyword-first method. Use when starting a weekly app, running Week 0 factory setup, doing ASO go/no-go, cloning the boilerplate, building a single-use-case feature, writing store metadata, or filming distribution. Trigger on weekly app, Max method, ASO, paywall, TestFlight, Play Store, $100/month, or "run week N for idea".
---

# Weekly App Factory

Ship one Flutter app per week. Searchable. Usable. Paywalled. Broke-friendly. Target is $100/month from a portfolio, not one miracle app.

The user provides the idea. Do not invent a new product category mid-week. Load **one extra skill per day** from the day table. Do not load the whole catalog.

Read references only when that day's work starts:

- [max-process.md](references/max-process.md) — 8 steps from the video
- [monday-go-nogo.md](references/monday-go-nogo.md) — keyword kill criteria
- [paywall.md](references/paywall.md) — weekly + yearly, trial, lifetime
- [store-listing.md](references/store-listing.md) — name, subtitle, keywords, privacy
- [broke-stack.md](references/broke-stack.md) — free tools only

Boilerplate lives at repo root: `app-boilerplate/`. ASO clone lives at `tools/respectaso/`. Monday research command: `python3 tools/research_keyword.py "<keyword>"`.

## Hard rules

1. Single use case. No social, no extra tabs, no "while we're here".
2. Keyword first. If Monday is no-go, kill the idea the same day.
3. Onboarding then paywall. Most subscriptions happen there.
4. Review prompt only after a successful aha moment, never after API failure.
5. Name and subtitle and keyword field are manual. AI writes description only.
6. Sunday definition of done: TestFlight + Play internal, listing filled, 5 videos filmed. Store "Ready for Sale" may lag review.
7. $0 ads until cash exists. Film yourself.
8. Paywall sits in front of any paid AI API call.
9. Backend default-deny. Never `allow read, write: if true`. Follow `.cursor/rules/factory-security.mdc`.
10. Never put personal inboxes, API keys, or `isAdmin` on a client-readable document.

## Stack

- Flutter, one codebase, iOS + Android
- Clone `app-boilerplate/` every Tuesday
- IAP: RevenueCat Spark or `purchases_flutter` / `in_app_purchase`
- AI (only if the idea needs it): Gemini Flash, hard daily cap, cache results
- ASO: local RespectASO at `tools/respectaso/` via `./tools/.venv/bin/python tools/research_keyword.py`. Fallback: App Store search
- No Mixpanel, no Superwall, no paid ASO SaaS until $100 MRR exists

## Day → skill (load these only)

| Day | Skills | Job |
|-----|--------|-----|
| Mon | this skill + `domain-name-brainstormer` + `content-research-writer` | Keyword go/no-go, name, hook |
| Tue | this skill + official Flutter/Dart skills | Clone boilerplate, IAP product IDs, ASO research note |
| Wed | this skill + Flutter architecture/routing + `verification-before-completion` | One-feature build, compile |
| Thu | this skill + `frontend-design` + `using-ui-stack` + `theme-factory` + `image-enhancer` | Better slop, icon, screenshots |
| Fri | this skill + `content-research-writer` | Metadata, submit both stores |
| Sat | this skill + `ios-simulator-skill` if tapping Simulator | Phone test, crashers only |
| Sun | this skill + `competitive-ads-extractor` only if the app is live | 5 videos, 5-line learn log |

Park everything else (Notion, docx/pdf, raffle, slack GIFs, MCP builder unless the app is an API wrapper).

## Week 0 (once, before the first Monday)

Do not start Week 1 until this is true:

- [ ] `tools/respectaso/` cloned (`./tools/clone-respectaso.sh`) and `./tools/.venv/bin/python tools/research_keyword.py "test"` returns JSON
- [ ] `app-boilerplate/` runs: 3-step onboarding → paywall → stub tabs → settings
- [ ] Privacy + terms GitHub Pages template exists (see `app-boilerplate/store/privacy.md`)
- [ ] Screenshot frames noted: iPhone 6.7" and Android 1080x1920
- [ ] `master-skills/imported/` populated (see [SOURCES.md](../../imported/SOURCES.md))
- [ ] Apple + Google developer accounts already exist (user confirmed)

If Week 0 is incomplete, finish it this session instead of building an app.

## Recurring week

Copy this checklist into the conversation and tick it.

```
Week: __
Idea: __
Keyword: __
Go / No-go: __
App name: __
Bundle id iOS: __
Application id Android: __
IAP weekly: __
IAP yearly or lifetime: __
```

### Monday — keyword go / no-go

Read [monday-go-nogo.md](references/monday-go-nogo.md).

1. Take the user's idea. Do not expand it.
2. Run `./tools/.venv/bin/python tools/research_keyword.py "<seed>"` from repo root. If the clone is missing, run `./tools/clone-respectaso.sh` first. Fallback: App Store / Play search screenshots.
3. Use the JSON `top_5`, `ratings_over_100_in_top_5`, `difficulty`, `classification`. `suggested_verdict` is a hint. You still apply [monday-go-nogo.md](references/monday-go-nogo.md).
4. **Go** only if people already search this, the exact name is not a giant's trademark/title, and the shelf is full of new thin apps.
5. **No-go** → user picks a backup idea the same day. Do not "improve" a dead keyword.
6. Lock: app name containing the keyword, one-sentence value prop, 3-second video hook.

Output a Monday brief (name, keyword, competitors, go/no-go, hook). Stop. Do not create the Flutter project on Monday unless the user asks.

### Tuesday — boilerplate + ASO doc

1. Copy `app-boilerplate/` to a sibling app folder named after the app (kebab-case). Prefer a sibling repo, not this catalog, if the user has an apps directory. Otherwise use `apps/<name>/` beside `app-boilerplate/`.
2. Rename display name, bundle IDs, application id.
3. Create IAP products in App Store Connect + Play Console **today**. This is the usual Friday blocker.
4. Generate an ASO research note: 3 onboarding titles, 4 paywall bullets, 4–6 screenshot headlines. Inspiration only — do not blindly paste. See [max-process.md](references/max-process.md).
5. Fill `lib/config/app_config.dart` (RevenueCat keys as placeholders if missing).

### Wednesday — core feature, one prompt

Use this shape. Change only the bracketed parts:

> Build the main feature screens for [app]: [camera/gallery or input], [result], history, collection/save, wire them into the main tabs. Make it compile. Do not add extra features.

Rules:

- One aha path.
- No accounts unless Apple review requires sign-in for the category.
- If AI is required: one Gemini call, structured JSON, cache, paywall in front. See [paywall.md](references/paywall.md).
- Compile. Fix analyzer issues. Do not start screenshot work.

Then run `verification-before-completion`: the aha path works on simulator or the user has a clear device test step.

### Thursday — better slop + visuals

1. One accent color that fits the category. Not purple-on-white generic AI.
2. Apply `using-ui-stack` (8px grid, 60-30-10) and `frontend-design` (one bold aesthetic).
3. 1024×1024 icon that **shows the job** (object + action), not an abstract blob.
4. 4–6 screenshots. Steal **structure** from the highest-rated competitor. Do not clone art.
5. Export iPhone 6.7" and Android 1080x1920.

### Friday — metadata and submit

Read [store-listing.md](references/store-listing.md).

Manual with the user:

- Name = primary keyword
- Subtitle = second keyword, no overlap with name
- Keyword field = remaining relevant terms, no repeats, do not pad with junk
- Description = AI, natural, keyword-rich
- Privacy URL, screenshots, IAP attached, Play Data safety

Submit both stores. If blocked (IAP, encryption, account deletion), fix the same day.

### Saturday — real device

Install TestFlight + Play internal. Test: happy path, permission denial, restore purchases, offline/API failure, paywall close → limited mode. Fix crashers and review-risks only.

### Sunday — fuel + learn

1. Film 5 videos of the aha moment on a phone. Post TikTok + Reels + Shorts. $0 spend.
2. Write a 5-line log: keyword, what shipped, what broke, keep or kill next week, next idea.
3. Do not start app #2 on Sunday night.

## Month 1

| Week | Goal |
|------|------|
| 0 | Factory + skills import |
| 1 | First searchable utility shipped (learn store forms) |
| 2 | Same factory, faster; fix whatever rejected you |
| 3 | Second category or a 10% better clone of a weak listing |
| 4 | Keep the one with impressions; kill the rest |

Do not split effort across four live apps until one has impressions. Ads only after a video clearly gets saves/comments **and** there is cash to lose.

## $100 math (after store cut)

About 4 yearly subscribers at ~$30, or ~25 weekly subscribers at ~$5. Month 1 may be $0. That is expected. Max shipped ~40 apps. Shipping the loop is the product until one listing gets search traffic.
