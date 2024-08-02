extends CharacterBody3D

const move_force := 10.0
var left_right := 0.0

func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if not Input.is_action_pressed("ui_left") and not Input.is_action_pressed("ui_right"):
		left_right = 0.0
	elif Input.is_action_just_pressed("ui_left"):
		left_right = -1.0
	elif Input.is_action_just_pressed("ui_right"):
		left_right = 1.0
	elif Input.is_action_just_released("ui_left"):
		left_right = 1.0
	elif  Input.is_action_just_released("ui_right"):
		left_right = -1.0
	set_velocity(Vector3(left_right, 0,0) * move_force)

	move_and_slide()
	apply_floor_snap()
