class_name LaneMarkers
extends Node3D

var progress_position := 0.0

func _process(delta):
	var p := GameState.progress_to_pos(progress_position)
	position.z = p.z + 0.1
	position.y = p.y + 0.1

	var up := global_position - GameState.terrain_pivot * Vector3(0,1,1)
	look_at(global_position + Vector3.RIGHT, up)
