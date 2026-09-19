extends Node
class_name MatchManager
## CS2-like round skeleton: first to 8 round wins, 100s round timer.
## Attach to Main scene later. Keeps logic in GDScript for fast iteration;
## hot paths (hitreg, movement) can move to Rust/C++ GDExtension later.

signal round_started(round_number: int)
signal round_ended(winner: String, reason: String)
signal match_ended(winner: String)

@export var rounds_to_win: int = 8
@export var round_time: float = 100.0
@export var freeze_time: float = 3.0

var team_scores := {"wardens": 0, "hexborn": 0}
var round_number := 0
var time_left := 0.0
var phase := "idle" # idle | freeze | live | ended

func _ready() -> void:
	start_match()

func start_match() -> void:
	team_scores = {"wardens": 0, "hexborn": 0}
	round_number = 0
	start_round()

func start_round() -> void:
	round_number += 1
	phase = "freeze"
	time_left = freeze_time
	round_started.emit(round_number)
	await get_tree().create_timer(freeze_time).timeout
	phase = "live"
	time_left = round_time

func _process(delta: float) -> void:
	if phase != "live":
		return
	time_left -= delta
	if time_left <= 0.0:
		end_round("hexborn", "time_expired_defenders_win")

func end_round(winner: String, reason: String) -> void:
	if phase != "live":
		return
	phase = "ended"
	team_scores[winner] += 1
	round_ended.emit(winner, reason)
	if team_scores[winner] >= rounds_to_win:
		match_ended.emit(winner)
		return
	await get_tree().create_timer(3.0).timeout
	start_round()

func time_string() -> String:
	var t := int(max(time_left, 0.0))
	return "%d:%02d" % [t / 60, t % 60]
