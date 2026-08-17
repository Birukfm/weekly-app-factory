# Monday go / no-go

The keyword is the problem the user already types into the store. If they do not search it, do not build it this week.

## Research steps

1. Seed = the user's idea in 2–4 words (`stamp identifier`, `plant identifier`, `tip calculator`).
2. From repo root run `./tools/.venv/bin/python tools/research_keyword.py "<seed>"` (uses `tools/respectaso/`). Fallback: type the seed into App Store search and Play Store search. Screenshot the ranking page.
3. From the top ranking app, collect related keywords. Drop:
   - Low popularity
   - Difficulty roughly above 60 (Max's cut)
   - Exact competitor app names
   - Generic junk (`app`, `free`, `pro`) unless it is truly how people search
4. For the chosen keyword, list the top 5 apps:

   | App | Ratings | Release year | Notes |
   |-----|---------|--------------|-------|
   |     |         |              |       |

5. Count how many have **more than 100 ratings**.

## Go (all must be true)

- People already search this phrase (popularity is not near-zero).
- You can put the phrase in the **app name** without colliding with a dominant exact-name listing.
- The shelf is winnable: few apps with 100+ ratings, and/or many 2025–2026 thin listings.
- The job is a **single use case** shippable in one Wednesday.
- Cost is broke-safe: offline or one cheap API call. No open-ended chatbot.

## No-go (any one is enough)

- Exact name is owned by a giant with thousands of ratings.
- Keyword is competitive and every result is a polished 2024-or-older incumbent.
- Idea requires accounts, social graph, marketplace liquidity, or a custom backend you do not have.
- Idea burns tokens on every screen (chat, unbounded generation).
- You cannot say the aha moment in one sentence.

On no-go: stop. Ask the user for the backup idea. Do not workshop the dead keyword into a "platform".

## Monday lock (required output)

```
Keyword: 
App name (contains keyword):
Subtitle keyword (no overlap):
One-sentence value prop:
3-second hook (what the video shows in the first 3 seconds):
Competitors (3):
Go / No-go:
```
