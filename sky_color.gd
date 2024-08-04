extends Camera3D

@onready var directional_light_3d = $"../DirectionalLight3D"
@export var colors : Array[Color] = []
@onready var reveal_the_cylinder_animation_player = $reveal_the_cylinder_animation_player

func make_color(progress: float) -> Color:
	var frac := progress / GameState.color_length
	var color_i = int(frac)
	frac = frac - color_i
	if color_i <= 0:
		return colors[0]
	elif color_i >= len(colors):
		return colors[len(colors) - 1]
	else:
		var a := colors[color_i - 1]
		var b := colors[color_i]
		return a.lerp(b, frac)

func _process(delta):
	environment.background_color = make_color(GameState.progress)
	directional_light_3d.light_color = make_color(GameState.progress + GameState.color_length * 0.5)
	if Input.is_key_pressed(KEY_Z) and Input.is_key_pressed(KEY_O):
		if reveal_the_cylinder_animation_player.assigned_animation != "reveal":
			reveal_the_cylinder_animation_player.play("reveal")
	else:
		reveal_the_cylinder_animation_player.play("RESET")
