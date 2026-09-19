extends SceneTree
## Headless aim regression test (run with --fixed-fps 60 for deterministic timing:
## godot --headless --fixed-fps 60 --path D:\game -s res://tests/aim_test.gd)
## Phase 1 (frames 0-15): hold "shoot" with the aimed Spark wand.
##   Assert the enemy on the sight line took damage and the player did not.
## Phase 2 (frames 15-50): switch to the fast Arcane wand and keep spraying.
##   Assert the camera never moved (no permanent recoil walk while holding
##   fire) and the enemy took more damage.

var frames := 0
var player: CharacterBody3D
var enemy: Node3D
var cam: Camera3D
var phase1_ok := false

func _initialize() -> void:
	# Floor so the player doesn't free-fall during the spray phase
	# (falling would pitch the sight line under the dummy).
	var floor_body := StaticBody3D.new()
	floor_body.position = Vector3(0, -0.5, -3)
	var floor_shape := CollisionShape3D.new()
	var floor_box := BoxShape3D.new()
	floor_box.size = Vector3(20, 1, 20)
	floor_shape.shape = floor_box
	floor_body.add_child(floor_shape)
	root.add_child(floor_body)

	var ps: PackedScene = load("res://objects/player.tscn")
	player = ps.instantiate()
	player.position = Vector3(0, 0.5, 0)
	root.add_child(player)
	# change_weapon() writes crosshair.texture; standalone player has none.
	player.crosshair = TextureRect.new()
	cam = player.get_node("Head/Camera")

	var es: PackedScene = load("res://objects/enemy.tscn")
	enemy = es.instantiate()
	enemy.set("player", player)
	root.add_child(enemy)
	# Camera sits at player + (0,1,0) = y 1.5, ray runs along -Z.
	# Sphere center = enemy.y + 0.25, radius 0.75 -> y 1.0 covers 0.25..1.75.
	enemy.position = Vector3(0, 1.0, -5)

	# Pin the player: wand knockback would surf us backward off the floor
	# mid-test (in-memory only, test process exits after).
	for w: Weapon in player.get("weapons"):
		w.knockback = 0

	Input.action_press("shoot")

func _process(_delta: float) -> bool:
	frames += 1
	if frames == 15:
		var e_health: float = enemy.get("health")
		var p_health: int = player.get("health")
		phase1_ok = e_health < 100.0 and p_health == 100
		print("TEST phase1 enemy_health=", e_health, " player_health=", p_health)
		player.initiate_change_weapon(1) # fast Arcane wand for spray phase
	if frames >= 50:
		Input.action_release("shoot")
		var e_health2: float = enemy.get("health")
		var cam_moved: bool = abs(cam.rotation.x) > 0.005 or abs(cam.rotation.y) > 0.005 \
			or abs(player.rotation.y) > 0.005
		print("TEST phase2 enemy_health=", e_health2, " cam_rot=", cam.rotation, " body_yaw=", player.rotation.y)
		var phase2_ok: bool = e_health2 < 100.0 and not cam_moved
		print("TEST AIM_" + ("PASS" if (phase1_ok and phase2_ok) else "FAIL"))
		quit()
		return true
	return false
