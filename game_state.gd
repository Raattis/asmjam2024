extends Node

var progress := 0.0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("ui_up"):
		progress += delta * 1.0
	if Input.is_action_pressed("ui_down"):
		progress -= delta * 1.0
	
func _input(event):
	if event is InputEventKey:
		if event.keycode == KEY_ESCAPE and event.is_pressed():
			get_tree().quit(0)
