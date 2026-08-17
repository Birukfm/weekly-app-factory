# Factory tools

Local tools the Weekly App Factory calls. Not skills.

## RespectASO

Free ASO keyword research. Clone lives at [`tools/respectaso`](respectaso/) ([upstream](https://github.com/respectlytics/respectaso), AGPL-3.0). The clone is gitignored so this Apache catalog does not vendor their license. Recreate with:

```bash
./tools/clone-respectaso.sh
```

That clones RespectASO (if needed) and creates `tools/.venv` with `requests`. Monday command:

```bash
./tools/.venv/bin/python tools/research_keyword.py "stamp identifier"
```

That uses RespectASO's iTunes search + popularity/difficulty/classification. Print JSON. Then apply [monday-go-nogo.md](../master-skills/playbook/weekly-app-factory/references/monday-go-nogo.md). `suggested_verdict` is a hint, not a ship decision.

Optional GUI: `cd tools/respectaso && docker compose up -d` then open http://localhost. Or install the [native Mac .dmg](https://github.com/respectlytics/respectaso/releases/latest).
