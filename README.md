# homebrew-catz

The litter's Homebrew tap. One line and a cat comes home.

Homebrew asks you to trust a tap that is not its own before it loads anything from it — so the first time it is tap,
trust, install:

```bash
brew tap catzoidhub/catz && brew trust catzoidhub/catz
brew install --cask devcatz dbcatz dialcatz
```

After that, any cat by its short name:

```bash
brew install --cask devcatz
brew install --cask dbcatz
brew install --cask dialcatz
brew install --cask docatz      # coming soon
brew install mcatzp             # coming soon — a formula, so no --cask
```

| Name | What it is |
| --- | --- |
| [`devcatz`](https://catzoid.com/devcatz) | *Finally, someone herds the cats.* A local development environment: every site on its own `https://*.localhost`, with every runtime, database, mail, search, tunnel and Docker in one app. |
| [`dbcatz`](https://catzoid.com/dbcatz) | *Curiosity won't kill this cat.* One window for MySQL, MariaDB, PostgreSQL, SQLite, Redis, Valkey, MongoDB and Elasticsearch. |
| [`dialcatz`](https://catzoid.com/dialcatz) | *Dial an endpoint. Hear it purr.* An API client for REST, GraphQL and WebSocket, with a self-hosted team server. |
| [`docatz`](https://catzoid.com/docatz) | A light container engine for your Mac. *Still a kitten — coming soon.* |
| [`mcatzp`](https://catzoid.com/mcatzp) (formula) | *The MCP with the cats inside.* One MCP server for your AI assistant to reach every cat. *Coming soon.* Install with `brew install catzoidhub/catz/mcatzp` (no `--cask`). |

Every cat is notarized by Apple, runs on macOS 13 or later (Apple silicon and Intel), and **updates itself** — Homebrew
only puts it in place the first time. All cats, no catch: free and open source, no account.

## Uninstall

```bash
brew uninstall --cask devcatz          # the app
brew uninstall --zap --cask devcatz    # the app and everything it keeps in ~/Library
```

DevCatz also changes a few things outside your home folder (the clean-URL services, `/etc/resolver` entries and its
local certificate authority). Remove those first with **DevCatz → Settings → Uninstall DevCatz**, which lists every
item before it touches anything — see [catzoid.com/docs/uninstall](https://catzoid.com/docs/uninstall).

## For maintainers

`scripts/bump.sh <app> <version>` reads the Apple silicon and Intel DMGs of that release on GitHub and writes the
version and both SHA-256 sums into `Casks/<app>.rb` — or, for MCatzP, the npm tarball's URL and SHA-256 into
`Formula/mcatzp.rb` — and prints the diff. `docatz` and `mcatzp` wait for their first releases. Commit and push; `brew update` picks it up.

The casks and formula are MIT-licensed; the apps themselves are GPL-3.0 and MCatzP Apache-2.0 — see each repository on
[github.com/catzoidhub](https://github.com/catzoidhub).
