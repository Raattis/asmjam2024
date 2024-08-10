extends Node3D

const end_nugget_scene = preload("res://end_nugget.tscn")

func _ready():
	var rand := RandomNumberGenerator.new()
	rand.seed = 3
	for i in range(len(GameState.nugs_eaten)):
		var nug := end_nugget_scene.instantiate()
		nug.position.x = rand.randf_range(2.8, 0.8)
		if rand.randi_range(0, 1) == 0:
			nug.position.x *= -1
		nug.position.z = rand.randf_range(-2.0, 1.0)
		nug.position.y = -nug.position.z * 0.6 + 0.2
		nug.position.x *= clamp(nug.position.z * 100.0 + 0.5, 1.0, 1000.0)
		nug.position.x += -0.3
		nug.position.y = pow(nug.position.y*1.5, 1.5) - 2.0
		nug.animation_progress = rand.randf_range(0, PI * 2)
		nug.animation_speed = rand.randf_range(0.9, 1.1)
		add_child(nug)
