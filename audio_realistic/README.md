# Real sounds - do NOT use PUBG rips (copyright + DMCA + no rigging)

Legal realistic sources:

## 1. Sonniss GDC bundle (recommended, royalty-free for games)
- 7.47 GB, 347 files, commercial OK, no attribution. NOT CC0 but game-safe.
- License: https://sonniss.com/gdc-bundle-license (media production only, no AI training)
- Download (run in PowerShell, ~7.5 GB - run once):
  ```
  .\audio_realistic\get_sonniss.ps1
  ```
  Then in Godot: copy wanted `.wav` (footsteps, gunshot->wand fire, impacts,
  UI) into `sounds/` and re-import. Replace `sounds/blaster.ogg` etc. in
  `weapons/wand_*.tres` + `objects/player.gd` Audio.play() calls.

## 2. Mixamo characters (realistic animated humans, free Adobe account)
- https://www.mixamo.com - download soldier/wizard + animations:
  Idle, Walk, Run, Strafe, Cast Spell, Death. Export FBX with skin.
- Import into Godot 4.6 via MixaBridge (free):
  https://github.com/uzairdeveloper223/mixabridge
  or Mixamo Animation Retargeter:
  https://github.com/RaidTheory/Godot-Mixamo-Animation-Retargeter
- This gives PUBG-like third-person animations; first-person arms use same clips.

## 3. Extra CC0 textures/models (same as environment)
- Poly Haven: https://polyhaven.com (CC0, no login) - we already use it for
  sky/ground/crate. Search "concrete, metal, fabric, soldier" for more.
- AmbientCG: https://ambientcg.com (CC0 PBR) - same pattern.

## Why not direct PUBG models?
PUBG assets are proprietary (Krafton). Downloading "PUBG models free" from
random sites = ripped copyrighted meshes, no skeleton/animations for Godot,
wrong scale, broken materials, and store/YouTube takedown risk. The path above
gets you 90% of the look legally with proper animations.
