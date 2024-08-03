extends MeshInstance3D

var cam_pos_prev = Vector3()
var cam_rot_prev = Quaternion()
var blur_amount : float = 0.0

func _process(delta):
	var velocity = Vector3(%chicken.linear_velocity.x * 0.01, GameState.progress_velocity, GameState.progress_velocity) * 100.0
	var ang_vel := Vector3(GameState.progress_velocity,0,0)
	
	if blur_amount == null:
		blur_amount = 0.0
	var a : float = blur_amount
	var b : float = GameState.stun_timer
	blur_amount = lerp(a, b, 1.0 - pow(0.01, delta))
	var min_amount : float = clamp(GameState.progress - GameState.color_length * 3.5, 0.0, 1.0) / 10.0
	if blur_amount < min_amount:
		blur_amount = min_amount
	
	var mat: ShaderMaterial = get_surface_override_material(0)
	mat.set_shader_parameter("linear_velocity", velocity * blur_amount)
	mat.set_shader_parameter("angular_velocity", ang_vel * blur_amount)
