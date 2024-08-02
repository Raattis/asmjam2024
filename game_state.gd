class_name GameStateT
extends Node

var progress := 0.0
var up_down := 0.0
var terrain_pivot : Vector3 = Vector3.ZERO
var terrain_scale : Vector3 = Vector3.ZERO 
var speed := 1.0
const progress_mult := 0.10620

func progress_to_pos(progress_pos : float) -> Vector3:
	var angle : float = (progress_pos - GameState.progress) * PI * 2.0 * progress_mult
	var p := Vector3.ZERO
	p.z = GameState.terrain_pivot.z - sin(angle) * GameState.terrain_scale.z * 0.5
	p.y = GameState.terrain_pivot.y + cos(angle) * GameState.terrain_scale.y * 0.5
	return p

func _ready():
	pass

func _process(delta):
	if not Input.is_action_pressed("ui_down") and not Input.is_action_pressed("ui_up"):
		up_down = 0.0
	elif Input.is_action_just_pressed("ui_down"):
		up_down = -1.0
	elif Input.is_action_just_pressed("ui_up"):
		up_down = 1.0
	elif Input.is_action_just_released("ui_down"):
		up_down = 1.0
	elif  Input.is_action_just_released("ui_up"):
		up_down = -1.0
	progress += delta * up_down * speed
	
func _input(event):
	if event is InputEventKey:
		if event.keycode == KEY_ESCAPE and event.is_pressed():
			get_tree().quit(0)
