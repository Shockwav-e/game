extends Node3D
## Quake arena host: builds the LibreQuake DM map at runtime with FuncGodot,
## then spawns the wand player at the first deathmatch start and wand-target
## dummies (reused flying enemies) at the farthest starts.
## Run headless: godot --headless --fixed-fps 60 --path D:\game res://scenes/quake_arena.tscn --quit-after 400

const PLAYER_SCENE: PackedScene = preload("res://objects/player.tscn")
const ENEMY_SCENE: PackedScene = preload("res://objects/enemy.tscn")

@onready var map: FuncGodotMap = $FuncGodotMap

var player: CharacterBody3D
var built := false
var frames_after_build := 0

func _ready() -> void:
	map.connect("build_complete", _on_build_complete)
	map.connect("build_failed", _on_build_failed)
	map.local_map_file = "res://maps_quake/lqdm13.map"
	if map.verify() != OK:
		printerr("TEST QUAKEMAP_VERIFY_FAIL")
		return
	map.build()

func _on_build_failed() -> void:
	printerr("TEST QUAKEMAP_FAIL")

func _on_build_complete() -> void:
	built = true
	var spawns: Array[Node] = get_tree().get_nodes_in_group("quake_dm_spawns")
	print("TEST QUAKEMAP_BUILT spawns=", spawns.size())
	if spawns.is_empty():
		printerr("TEST QUAKEMAP_NOSPAWNS")
		return
	spawns.sort_custom(func(a: Node3D, b: Node3D) -> bool: return a.name < b.name)

	player = PLAYER_SCENE.instantiate()
	add_child(player)
	# Standalone player has no HUD crosshair node; give it a dummy so
	# change_weapon() can assign the texture.
	player.crosshair = TextureRect.new()
	_place_on_floor(player, spawns[0])

	# Two target dummies at the farthest starts from the player.
	var by_dist: Array = spawns.slice(1)
	by_dist.sort_custom(func(a: Node3D, b: Node3D) -> bool:
		return a.global_position.distance_to(player.global_position) > b.global_position.distance_to(player.global_position))
	for i: int in mini(2, by_dist.size()):
		var e: Node3D = ENEMY_SCENE.instantiate()
		add_child(e)
		e.set("player", player)
		e.position = (by_dist[i] as Node3D).global_position + Vector3(0, 1.0, 0)

func _place_on_floor(body: CharacterBody3D, marker: Node3D) -> void:
	body.position = (marker as Node3D).global_position + Vector3(0, 0.7, 0)
	body.rotation.y = (marker as Node3D).global_rotation.y

func _physics_process(_delta: float) -> void:
	if not built or player == null:
		return
	frames_after_build += 1
	if frames_after_build == 120:
		# Player should be standing on map geometry, not falling through.
		print("TEST player_y=", player.position.y, " vel=", player.velocity)
		print("TEST QUAKEMAP_SPAWN_" + ("PASS" if player.position.y > -50.0 and absf(player.velocity.y) < 3.0 else "FAIL"))
