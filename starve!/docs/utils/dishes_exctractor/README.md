# dishes_data extractor

Pure `extract(game, mod) -> dishes_data.json` generator.

- `sandbox.lua` — loads Lua source in an isolated environment.
- `game.lua` — vanilla snapshot from `scripts/` (`preparedfoods.lua` + `tuning`/`strings`/`constants`).
- `mod.lua` — replays `starve!/features/dishes.lua` with recording stubs.
- `build.lua` — merges vanilla + recorded deltas; drops the skip list.
- `json.lua` — deterministic, key-ordered JSON writer.
- `main.lua` — entry point, writes `../dishes_data.json`.

## Run

Requires LuaJIT (the scripts use Lua 5.1 `unpack`).

```fish
cd dishes_table/exctractor
nix run nixpkgs#luajit -- main.lua
```

Or from the repo root:

```fish
nix run nixpkgs#luajit -- dishes_table/exctractor/main.lua
```

Set `EXTRACTOR_VERBOSE=1` to log stubbed `require`s.

## Output

`dishes_table/dishes_data.json`, 66 crockpot dishes (preparedfoods minus `beefalofeed`,
`beefalotreat`, `batnosehat`, `dustmeringue`). `modded` holds only fields that differ
from `vanilla`.
