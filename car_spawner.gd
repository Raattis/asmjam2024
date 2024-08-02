extends Node

const car_scene := preload("res://car.tscn")

func _ready():
	for i in range(30):
		var car := car_scene.instantiate()
		car.progress_position = i * 0.4
		car.speed = 50.0 + i * 10.0
		car.position.x += fmod(i * 123.0, GameState.terrain_scale.x * 2) - GameState.terrain_scale.x
		add_child(car)
		if i % 2 == 0:
			car.speed *= -1

func _process(delta):
	pass
