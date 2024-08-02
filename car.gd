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
	if x > GameState.terrain_scale.x * 0.9:
		x = fmod(x, -GameState.terrain_scale.x * 1.6) - GameState.terrain_scale.x * 0.8
	elif x < -GameState.terrain_scale.x * 0.9:
		x = -fmod(-x, GameState.terrain_scale.x * 1.6) + GameState.terrain_scale.x * 0.8
	position.x = x

	var up := global_position - GameState.terrain_pivot * Vector3(0,1,1)
	look_at(global_position + Vector3.RIGHT * speed, up)
