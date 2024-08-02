extends RigidBody3D

const move_force := 300.0
var left_right := 0.0
@onready var feather_particles = [%feather_particles, %feather_particles2, %feather_particles3]
var feather_particles_index := 1

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
		feather_particles_index = (feather_particles_index + 1) % len(feather_particles)
		var particles : CPUParticles3D = feather_particles[feather_particles_index]
		if not particles.emitting:
			particles.global_position = global_position
			particles.emitting = true
			if body.speed > 0:
				particles.rotation.y = 0
			else:
				particles.rotation.y = PI
	elif body is Nugget:
		print("nugget")
	else:
		print("other")
