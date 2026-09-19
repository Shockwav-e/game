extends SceneTree
## Headless aim regression test (run: godot --headless --path D:\game -s res://tests/aim_test.gd)
## Spawns the player, puts an enemy dummy 5m ahead on the crosshair line,
## holds down "shoot", then asserts: enemy took damage AND player did NOT
## damage itself (the old exclude_parent=false bug hit our own capsule).

var frames := 0
var player: CharacterBody3D
var enemy: Node3D

func _initialize() -> void:
	var ps: PackedScene = load("res://objects/player.tscn")
	player = ps.instantiate()
	player.position = Vector3(0, 0.5, 0)
	root.add_child(player)
	# change_weapon() writes crosshair.texture; standalone player has none.
	player.crosshair = TextureRect.new()

	var es: PackedScene = load("res://objects/enemy.tscn")
	enemy = es.instantiate()
	enemy.set("player", player)
	root.add_child(enemy)
	# Camera sits at player + (0,1,0) = y 1.5, ray runs along -Z.
	# Sphere center = enemy.y + 0.25, radius 0.75 -> y 1.0 covers 0.25..1.75.
	enemy.position = Vector3(0, 1.0, -5)

	Input.action_press("shoot")

func _process(_delta: float) -> bool:
	frames += 1
	if frames >= 20:
		Input.action_release("shoot")
		var e_health: float = enemy.get("health")
		var p_health: int = player.get("health")
		print("TEST enemy_health=", e_health, " player_health=", p_health)
		var ok: bool = e_health < 100.0 and p_health == 100
		print("TEST AIM_" + ("PASS" if ok else "FAIL"))
		quit()
		return true
	return false
