class_name GameStateT
extends Node

var progress := 0.0
var terrain_pivot : Vector3 = Vector3.ZERO
var terrain_scale : Vector3 = Vector3.ZERO 
const progress_mult := PI * 2.0
const progress_speed := 0.5 / progress_mult
var progress_velocity := 0.0
var stun_timer := 0.0

func progress_to_pos(progress_pos : float) -> Vector3:
	var angle : float = (progress_pos - GameState.progress) * progress_mult
	var p := Vector3.ZERO
	p.z = GameState.terrain_pivot.z - sin(angle) * GameState.terrain_scale.z * 0.5
	p.y = GameState.terrain_pivot.y + cos(angle) * GameState.terrain_scale.y * 0.5
	return p

func _ready():
	pass

func is_stunned():
	return stun_timer > 0.0

func _process(delta):
	if stun_timer > 0.0:
		stun_timer -= delta

	progress += delta * progress_velocity
	
func _input(event):
	if event is InputEventKey:
		if event.keycode == KEY_ESCAPE and event.is_pressed():
			get_tree().quit(0)
