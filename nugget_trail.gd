class_name NuggetTrail
extends Node3D

var next : Node3D = null
var progress_position := 0.0
const max_dist_progress := 0.005
const max_dist_x := 1.5
var animation_progress := 0.0

func _process(delta):
	var target_prog := 0.0
	var target_x := next.global_position.x
	
	if next is Chicken:
		target_prog = GameState.progress - 0.122
	elif next is NuggetTrail:
		target_prog = next.progress_position

	var normalized_dist := Vector2((target_x - position.x) / max_dist_x, (target_prog - progress_position) / max_dist_progress)
	if normalized_dist.length_squared() > 1.0:
		normalized_dist = normalized_dist.normalized()

	position.x = target_x - normalized_dist.x * max_dist_x
	progress_position = target_prog - normalized_dist.y * max_dist_progress

	animation_progress += delta * 3.0
	get_child(0).position.y = abs(sin(animation_progress))

	var p := GameState.progress_to_pos(progress_position)
	position.z = p.z + 0.1
	position.y = p.y + 0.1

	var up := global_position - GameState.terrain_pivot * Vector3(0,1,1)
	look_at(next.global_position, up)
