extends Node

const car_scene := preload("res://car.tscn")

func _ready():
	const lane_count := 30
	for i in range(lane_count):
		var speed := 50.0 + i * 10.0
		var progress : float = i * GameState.progress_mult / lane_count
		for j in range(1 + 255 / speed):
			var car := car_scene.instantiate()
			car.progress_position = progress
			car.speed = speed
			var offset : float = j * car.get_node("MeshInstance3D").scale.z * 1.5 + i * 123.0
			if j == 0:
				print(i, ", ", offset, ", ", progress)
			car.position.x += fmod(offset, GameState.terrain_scale.x * 0.8) - GameState.terrain_scale.x * 0.4
			add_child(car)
			if i % 2 == 0:
				car.speed *= -1

func _process(delta):
	pass
