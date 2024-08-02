extends Node3D

var despawn := 0.0
@onready var nuggets = $".."
const despawn_dur := 2.0

func _process(delta):
	if nuggets.collected:
		despawn += delta
		if despawn > despawn_dur * 0.7:
			scale = lerp(scale, Vector3.ZERO, 1 - pow(0.001, delta))
		if despawn > despawn_dur:
			nuggets.queue_free()
	position.y = 0.2 + sin(Time.get_ticks_msec() / 300.0) * 0.3 + despawn * 20.0
	rotation.y += delta + despawn
