extends OmniLight3D
## Converts Quake `light` entity keys into a Godot light when FuncGodot builds the map.
## Attached via the `light` entity definition (maps_quake/fgd_light.tres).

func _func_godot_apply_properties(props: Dictionary) -> void:
	var brightness := 300.0
	if props.has("light"):
		brightness = float(str(props["light"]))
	var col := Color.WHITE
	if props.has("_color"):
		var c: PackedFloat64Array = str(props["_color"]).split_floats(" ")
		if c.size() >= 3:
			col = Color(c[0], c[1], c[2])
	light_color = col
	light_energy = clampf(brightness / 300.0, 0.1, 4.0)
	omni_range = clampf(brightness / 300.0 * 9.0, 2.0, 24.0)
	omni_attenuation = 1.2
	shadow_enabled = false
