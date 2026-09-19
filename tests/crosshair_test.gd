extends SceneTree
## Headless crosshair regression test (run: godot --headless --path D:\game -s res://tests/crosshair_test.gd)
## The damage ray travels through the exact screen center, so the drawn
## crosshair box (get_global_rect includes the Control scale-about-pivot)
## must be centered on the viewport within 2px.
## (Old 40x40 rect + (64,64) pivot drew the crosshair ~28px off-center per
##  axis: shots "missed" where aimed.)

var frames := 0
var crosshair: TextureRect

func _initialize() -> void:
	var main: PackedScene = load("res://scenes/main.tscn")
	var inst: Node = main.instantiate()
	root.add_child(inst)
	crosshair = inst.get_node("HUD/Crosshair")

func _process(_delta: float) -> bool:
	frames += 1
	if frames >= 3:
		var screen_center: Vector2 = Vector2(root.size) * 0.5
		var drawn_center: Vector2 = crosshair.get_global_rect().get_center()
		var err: float = screen_center.distance_to(drawn_center)
		print("TEST rect=", crosshair.get_global_rect(), " size_prop=", crosshair.size, " offs=", crosshair.offset_left, ",", crosshair.offset_top, ",", crosshair.offset_right, ",", crosshair.offset_bottom)
		print("TEST CROSSHAIR_" + ("PASS" if err <= 2.0 else "FAIL"))
		quit()
		return true
	return false
