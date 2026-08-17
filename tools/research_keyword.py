#!/usr/bin/env python3
"""Monday keyword research using the local RespectASO clone.

Calls Apple's public iTunes Search API from this machine and scores with
RespectASO's popularity, difficulty, and classification functions.

Usage (from repo root):
    python3 tools/research_keyword.py "stamp identifier"
    python3 tools/research_keyword.py "stamp identifier,postage stamp" --country us
"""

from __future__ import annotations

import argparse
import json
import sys
import time
from pathlib import Path

ROOT = Path(__file__).resolve().parent
RESPECTASO = ROOT / "respectaso"


def load_respectaso() -> None:
    if not (RESPECTASO / "aso" / "services.py").exists():
        sys.stderr.write(
            "RespectASO is missing. From repo root run:\n"
            "  ./tools/clone-respectaso.sh\n"
        )
        raise SystemExit(1)
    sys.path.insert(0, str(RESPECTASO))


def parse_release_year(release_date: str) -> int | None:
    if not release_date or len(release_date) < 4:
        return None
    try:
        return int(release_date[:4])
    except ValueError:
        return None


def suggest_verdict(
    popularity: int | None,
    difficulty: int,
    ratings_over_100: int,
    exact_name_owned: bool,
    classification: str,
) -> tuple[str, list[str]]:
    reasons: list[str] = []
    if popularity is None or popularity < 15:
        reasons.append("popularity is near-zero / Low Volume")
    if difficulty >= 60:
        reasons.append(f"difficulty {difficulty} is at or above Max's ~60 cut")
    if exact_name_owned:
        reasons.append("a top app already owns this exact name")
    if ratings_over_100 >= 4:
        reasons.append("four or more of the top five have 100+ ratings")
    if classification in {"High Competition", "Avoid", "Low Volume"}:
        reasons.append(f"RespectASO classifies this as {classification}")
    if reasons:
        return "no-go", reasons
    if classification in {"Sweet Spot", "Hidden Gem", "Good Target"}:
        return "go", [f"RespectASO classifies this as {classification}"]
    return "borderline", [f"RespectASO classifies this as {classification}"]


def research_one(keyword: str, country: str) -> dict:
    from aso.scoring import calc_opportunity, classify_keyword
    from aso.services import DifficultyCalculator, ITunesSearchService, PopularityEstimator
    itunes = ITunesSearchService()
    competitors = itunes.search_apps(keyword, country=country, limit=25)
    difficulty, breakdown = DifficultyCalculator().calculate(competitors, keyword=keyword)
    popularity = PopularityEstimator().estimate(competitors, keyword)
    opportunity = calc_opportunity(popularity or 0, difficulty)
    classification = classify_keyword(popularity or 0, difficulty)
    top_five = []
    for app in competitors[:5]:
        year = parse_release_year(str(app.get("releaseDate") or ""))
        top_five.append(
            {
                "name": app.get("trackName") or "",
                "seller": app.get("sellerName") or "",
                "ratings": int(app.get("userRatingCount") or 0),
                "stars": round(float(app.get("averageUserRating") or 0), 2),
                "release_year": year,
                "genre": app.get("primaryGenreName") or "",
                "url": app.get("trackViewUrl") or "",
            }
        )
    ratings_over_100 = sum(1 for row in top_five if row["ratings"] > 100)
    keyword_lower = keyword.strip().lower()
    exact_name_owned = any(row["name"].strip().lower() == keyword_lower for row in top_five)
    verdict, reasons = suggest_verdict(
        popularity,
        difficulty,
        ratings_over_100,
        exact_name_owned,
        classification,
    )
    return {
        "keyword": keyword,
        "country": country,
        "popularity": popularity,
        "difficulty": difficulty,
        "opportunity": opportunity,
        "classification": classification,
        "ratings_over_100_in_top_5": ratings_over_100,
        "exact_name_owned": exact_name_owned,
        "suggested_verdict": verdict,
        "reasons": reasons,
        "top_5": top_five,
        "result_count": len(competitors),
        "difficulty_interpretation": breakdown.get("interpretation"),
    }


def main() -> None:
    parser = argparse.ArgumentParser(description="Monday ASO research via local RespectASO")
    parser.add_argument("keywords", help="Comma-separated keywords, max 20")
    parser.add_argument("--country", default="us", help="App Store country code (default: us)")
    args = parser.parse_args()
    load_respectaso()
    keywords = [part.strip() for part in args.keywords.split(",") if part.strip()][:20]
    if not keywords:
        raise SystemExit("No keywords provided.")
    country = args.country.strip().lower()
    results = []
    for index, keyword in enumerate(keywords):
        if index > 0:
            time.sleep(2)
        results.append(research_one(keyword, country))
    payload = {
        "country": country,
        "results": results,
    }
    json.dump(payload, sys.stdout, indent=2)
    sys.stdout.write("\n")


if __name__ == "__main__":
    main()
