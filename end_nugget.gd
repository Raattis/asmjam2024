extends MeshInstance3D

var animation_progress := 0.0
var animation_speed := 1.0
var orig_y := 0.0

func _ready():
	orig_y = position.y

func _process(delta):
	animation_progress += delta * animation_speed
	position.y = orig_y + abs(sin(animation_progress * 3.0))
	rotation.y = animation_progress * 8.0 * animation_speed
