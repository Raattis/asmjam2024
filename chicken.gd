class_name Chicken
extends RigidBody3D

const move_force := 700.0
var left_right := 0.0
var up_down := 0.0

var knock_progress := 1.0
@onready var feather_particles = [%feather_particles, %feather_particles2, %feather_particles3]
var feather_particles_index := 1

@onready var car_collision_cast = $car_collision_cast
const collision_force := 50.0

var animation_progress := 0.0
@onready var chicken_mesh = $chicken_mesh

const nugget_trail = preload("res://nugget_trail.tscn")
var nugger_trail_head : NuggetTrail = null

func _ready():
	contact_monitor = true

func _process(delta : float):
	if GameState.victory:
		position.x = lerp(position.x, 0.0, 1.0 - pow(0.001, delta))
		return

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

	var lerp_factor := 1.0 - pow(0.1, delta)
	var lerp_factor_fast := 1.0 - pow(0.001, delta)
	if not GameState.is_stunned():
		GameState.progress_velocity = lerp(GameState.progress_velocity, GameState.progress_speed * up_down, lerp_factor)
		angular_damp = lerp(angular_damp, 5.0, lerp_factor)
		rotation = rotation.slerp(Vector3.ZERO, lerp_factor_fast)
	else:
		GameState.progress_velocity = knock_progress
		knock_progress = lerp(knock_progress, 0.0, lerp_factor)
 
	if Input.is_key_pressed(KEY_I) and Input.is_key_pressed(KEY_P):
		GameState.progress_velocity = GameState.progress_speed * 5

	apply_force(Vector3(left_right, 0,0) * move_force)
	if position.x > GameState.terrain_scale.x * 0.8:
		position.x = 0
	if position.x < -GameState.terrain_scale.x * 0.8:
		position.x = 0
	if Input.is_key_pressed(KEY_R):
		position.x = 0

	const border := 25.0
	if position.x < -border or position.x > border:
		apply_force(Vector3(-position.x * 500.0,0,0))
		apply_torque_impulse(Vector3.FORWARD * clamp(position.x * 0.1, -10.0, 10.0) + Vector3.RIGHT * knock_progress * 3.0)

	if car_collision_cast.is_colliding() and not Input.is_key_pressed(KEY_I):
		var body : Node3D = car_collision_cast.get_collider(0)
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
			knock_progress = (body.position.z - position.z) * 0.1
			GameState.stun_timer = 0.5
			angular_damp = 0.01
			apply_force(Vector3(1,0,0) * body.speed * collision_force)
			apply_torque_impulse(Vector3.FORWARD * clamp(body.speed * 0.1, -10.0, 10.0) + Vector3.RIGHT * knock_progress * 3.0)
		elif body is Nuggets:
			if not body.collected:
				body.collect()
				var trail := nugget_trail.instantiate()
				trail.next = self
				trail.position.y = 10000
				$"..".add_child(trail)
				if nugger_trail_head:
					nugger_trail_head.next = trail
				nugger_trail_head = trail
		else:
			print("other: ", body.name)
	
	var current_speed : float = abs(GameState.progress_velocity) * 100.0 + abs(linear_velocity.x) * 0.4
	if abs(current_speed) < 1.0:
		chicken_mesh.position.y = lerp(chicken_mesh.position.y, 0.0, lerp_factor_fast)
		chicken_mesh.rotation = lerp(chicken_mesh.rotation, Vector3.ZERO, lerp_factor_fast)
	else:
		animation_progress += delta * current_speed
		chicken_mesh.position.y = abs(sin(animation_progress + PI * 0.5)) * 1.0
		chicken_mesh.position.x = sin(animation_progress + PI * 0.5) * 0.5
		chicken_mesh.rotation.z = sin(animation_progress) * 0.1
		
