extends MeshInstance3D



# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	rotation.x = get_node("/root/GameState").progress * 100 / scale.z
	#position.z = -scale.z * 0.45
	#position.y = -scale.y * 0.24
	position.x = 0
