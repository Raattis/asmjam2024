class_name Nugget
extends Node3D

var progress_position := 0.1

func _ready():
	pass

func _process(_delta):
	var p := GameState.progress_to_pos(progress_position)
	position.z = p.z
	position.y = p.y
