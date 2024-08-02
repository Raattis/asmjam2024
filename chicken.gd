extends RigidBody3D

const move_force := 100.0
var left_right := 0.0
@onready var feather_particles = %feather_particles


func _ready():
	contact_monitor = true

func _process(_delta):
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
	apply_force(Vector3(left_right, 0,0) * move_force)
	if position.x > GameState.terrain_scale.x * 0.8:
		position.x = 0
	if position.x < -GameState.terrain_scale.x * 0.8:
		position.x = 0
		
	if Input.is_key_pressed(KEY_R):
		position.x = 0

func _on_body_entered(body):
	if body is Car:
		if not feather_particles.emitting:
			feather_particles.global_position = global_position
			feather_particles.emitting = true
			if body.speed > 0:
				feather_particles.rotation.y = 0
			else:
				feather_particles.rotation.y = PI
	elif body is Nugget:
		print("nugget")
	else:
		print("other")
