class_name Nuggets
extends Node3D

var progress_position := 0.0
var collected := false
var lane_index := -99

func _process(delta):
	var p := GameState.progress_to_pos(progress_position)
	position.z = p.z + 0.1
	position.y = p.y + 0.1

func collect():
	if collected:
		return
	collected = true
	GameState.nugs_eaten.append(lane_index)
	print("collected!")
