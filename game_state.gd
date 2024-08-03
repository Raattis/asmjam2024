class_name GameStateT
extends Node

var progress := -0.1
const color_length := 0.5

var terrain_pivot : Vector3 = Vector3.ZERO
var terrain_scale : Vector3 = Vector3.ZERO 
const progress_mult := PI * 2.0
const progress_speed := 0.7 / progress_mult
var progress_velocity : float = 0.0
var stun_timer : float = 0.0
var nugs_eaten : Array[int] = []

const lane_count := 30
const lane_width := 1.0 / lane_count

var game_started := false
var victory := false
const victory_limit := 3.0
var ended := false
const end_limit := 10.0
var ended_timeout := 1.0
var restart_game := false

func progress_to_pos(progress_pos : float) -> Vector3:
	var angle : float = (progress_pos - GameState.progress) * progress_mult
	var p := Vector3.ZERO
	p.z = GameState.terrain_pivot.z - sin(angle) * GameState.terrain_scale.z * 0.5
	p.y = GameState.terrain_pivot.y + cos(angle) * GameState.terrain_scale.y * 0.5
	return p

func _ready():
	restart_game_now()

func restart_game_now():
	print("restart_game_now()")
	progress = -0.1
	progress_velocity = 0.0
	stun_timer = 0.0
	nugs_eaten = []
	game_started = false
	victory = false
	ended = false
	ended_timeout = 1.0
	restart_game = false

func is_stunned():
	return stun_timer > 0.0

func _process(delta):
	if victory:
		if progress > end_limit:
			ended = true
			progress_velocity = 0.0
			ended_timeout -= delta
			if ended_timeout < 0 and Input.is_anything_pressed():
				restart_game = true
			return
		progress += delta * color_length * 1.0
		return
	
	if stun_timer > 0.0:
		stun_timer -= delta

	progress += delta * progress_velocity
	
	if progress > victory_limit:
		victory = true
	
func _input(event):
	if event is InputEventKey:
		if event.keycode == KEY_ESCAPE and event.is_pressed():
			OS.set_restart_on_exit(false)
			get_tree().quit(0)
		if event.keycode == KEY_R and event.is_pressed():
			OS.set_restart_on_exit(true)
			get_tree().quit(0)
