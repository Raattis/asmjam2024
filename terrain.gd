extends MeshInstance3D

# Called when the node enters the scene tree for the first time.
func _ready():
	GameState.terrain_pivot = position
	GameState.terrain_scale = scale

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	rotation.x = GameState.progress * 100 / scale.z
	#position.z = -scale.z * 0.45
	#position.y = -scale.y * 0.24
	position.x = 0
	GameState.terrain_pivot = position
	GameState.terrain_scale = scale
