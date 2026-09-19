# Real map: LibreQuake lqdm13 (deathmatch arena, real open-source FPS)

Source: https://github.com/lavenderdotpet/LibreQuake (free BSD-licensed Quake remake)
- Map: `lqdm13.map` - deathmatch arena source from `lq1/maps/src/dm/` (175 KB).
- Textures: 7 PNGs in `textures/` (dev set: `lq_dev`, `lq_utility`, `lq_liquidsky`).
- Importer: FuncGodot (MIT) in `res://addons/func_godot`.

License: models/textures/sounds are BSD-3-Clause (permissive, commercial OK,
see LibreQuake `docs/COPYING`). GPL2 in that project covers QuakeC/progs.dat
only, which we do NOT use. Keep this attribution if you ship the map.

## How it works
`res://scenes/quake_arena.tscn` builds the .map at RUNTIME via FuncGodot
(`scripts/quake_arena.gd`): geometry + concave collision + OmniLights from
Quake `light` entities + Marker3D DM spawns. Player spawns at start 0,
two target dummies at the farthest starts.

## v1 limits (next steps)
- Doors are static (func_door doesn't open yet).
- Teleporters, pickups, pushers are inert (markers only).
- `*tele3` animated faces fall back to gray (no shader yet).
- Verify: godot --headless --fixed-fps 60 --path D:\game res://scenes/quake_arena.tscn --quit-after 400
