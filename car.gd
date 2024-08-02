class_name Car
extends AnimatableBody3D

var progress_position := 0.0
const progress_mult := 0.10620
var speed := 200
var offset_x := 0.0

func _process(delta):
	var p := GameState.progress_to_pos(progress_position)
	position.z = p.z
	position.y = p.y
	var x = offset_x + Time.get_ticks_msec() / 1000.0 * speed
	const w := 1.0
	if x > 0:
		x = fmod(x, -GameState.terrain_scale.x * w) - GameState.terrain_scale.x * w * 0.5
	elif x < 0:
		x = -fmod(-x, GameState.terrain_scale.x * w) + GameState.terrain_scale.x * w * 0.5
	position.x = x

	var up := global_position - GameState.terrain_pivot * Vector3(0,1,1)
	look_at(global_position + Vector3.RIGHT * speed, up)
