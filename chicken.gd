extends RigidBody3D

const move_force := 300.0
var left_right := 0.0
var up_down := 0.0

var knock_progress := 1.0
@onready var feather_particles = [%feather_particles, %feather_particles2, %feather_particles3]
var feather_particles_index := 1

@onready var car_collision_cast = $car_collision_cast
const collision_force := 20.0

func _ready():
	contact_monitor = true

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

	if not GameState.is_stunned():
		GameState.progress_velocity = lerp(GameState.progress_velocity, GameState.progress_speed * up_down, 1.0 - pow(0.1, delta))
	else:
		GameState.progress_velocity = knock_progress
		knock_progress = lerp(knock_progress, 0.0, 1.0 - pow(0.1, delta))
 
	apply_force(Vector3(left_right, 0,0) * move_force)
	if position.x > GameState.terrain_scale.x * 0.8:
		position.x = 0
	if position.x < -GameState.terrain_scale.x * 0.8:
		position.x = 0
	if Input.is_key_pressed(KEY_R):
		position.x = 0

	if car_collision_cast.is_colliding():
		var body : Node3D = car_collision_cast.get_collider(0)
		if body is Car:
			apply_force(Vector3(1,0,0) * body.speed * collision_force)
			feather_particles_index = (feather_particles_index + 1) % len(feather_particles)
			var particles : CPUParticles3D = feather_particles[feather_particles_index]
			if not particles.emitting:
				particles.global_position = global_position
				particles.emitting = true
				if body.speed > 0:
					particles.rotation.y = 0
				else:
					particles.rotation.y = PI
			knock_progress = (body.position.z - position.z) * 1.0
			GameState.stun_timer = 0.5
		elif body is Nugget:
			print("nugget")
		else:
			print("other")
			
