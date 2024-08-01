extends RigidBody3D

const move_force := 100.0

func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("ui_left"):
		apply_force(Vector3(-1, 0,0) * move_force)
	if Input.is_action_pressed("ui_right"):
		apply_force(Vector3(1, 0,0) * move_force)
