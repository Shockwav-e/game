# Realistic assets (CC0, Poly Haven - no login, commercial OK)

Downloaded via https://api.polyhaven.com - all CC0 1.0 Universal.

## Sky / lighting
- `sky/venice_sunset_1k.hdr` - outdoor sunset HDRI, 1k preview.
  Source: https://polyhaven.com/a/venice_sunset
  For final quality re-download 4k/8k `.hdr` from same page and replace.
  Used by: `res://scenes/realistic-environment.tres`

## Ground PBR (asphalt_02, 1k preview)
- `textures/asphalt_02_1k/albedo.jpg` + `normal.jpg` + `roughness.jpg`
  Source: https://polyhaven.com/a/asphalt_02
  Used by: `res://assets_realistic/realistic_ground.tres`
  For final: download 4k + AO + displacement from same page.

## Prop (old_military_crate, 1k glTF)
- `models/old_military_crate/old_military_crate_1k.gltf` + `.bin` + `textures/`
  Source: https://polyhaven.com/a/old_military_crate
  PUBG-style military prop. Drag the .gltf into your map in Godot 4.6.
  It auto-imports with PBR (diffuse + normal + ARM).

## Upgrade path to PUBG look
1. In Godot: open `scenes/main.tscn`, select WorldEnvironment -> Environment =
   `scenes/realistic-environment.tres`.
2. Ground: assign `assets_realistic/realistic_ground.tres` to your floor
   StaticBody3D material_override.
3. Props: drag `old_military_crate_1k.gltf` into Level, add StaticBody3D +
   CollisionShape3D (Box) manually.
4. Renderer: already Forward Plus in project.godot:20. Keep MSAA 3D + SSAO/SSIL on.
5. Replace 1k with 4k before export (same filenames, Godot reimports).

License: CC0 - no attribution required, but link appreciated.
Full terms: https://polyhaven.com/license
