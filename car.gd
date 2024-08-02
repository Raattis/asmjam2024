class_name Car
extends AnimatableBody3D

var progress_position := 0.0
const progress_mult := 0.10620
var speed := 200

func _process(delta):
	var p := GameState.progress_to_pos(progress_position)
	position.z = p.z
	position.y = p.y
	var progressive_speed_increasse := clampf(GameState.progress, 0.2, 10.0)
	position.x = position.x + delta * speed * progressive_speed_increasse
	if position.x > GameState.terrain_scale.x * 0.9:
		position.x = -GameState.terrain_scale.x * 0.8
	elif position.x < -GameState.terrain_scale.x * 0.9:
		position.x = GameState.terrain_scale.x * 0.8

	var up := global_position - GameState.terrain_pivot * Vector3(0,1,1)
	look_at(global_position + Vector3.RIGHT * speed, up)