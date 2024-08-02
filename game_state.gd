extends Node

var progress := 0.0
var up_down := 0.0

func _ready():
	pass # Replace with function body.

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
	progress += delta * up_down
	
func _input(event):
	if event is InputEventKey:
		if event.keycode == KEY_ESCAPE and event.is_pressed():
			get_tree().quit(0)
