extends Node3D

@onready var tepastelu_player = $tepastelu_player
@onready var turpaan_player = $turpaan_player
@onready var pipckup_player = $pipckup_player
@onready var bgm = $bgm

var disable_bgm := false

func _ready():
	pass # Replace with function body.

func _process(delta):
	var chicken : Chicken = get_node_or_null("/root/Node3D/chicken")
	if chicken:
		if (abs(chicken.up_down) > 0 or abs(chicken.left_right) > 0) \
			and (chicken.linear_velocity.length() > 0.2 or abs(GameState.progress_velocity) > 0.05) \
			and not GameState.is_stunned():
			tepastelu_player.max_db = lerp(tepastelu_player.max_db, 3.0, 1 - pow(0.001, delta))
			if not tepastelu_player.playing:
				tepastelu_player.play()
		else:
			tepastelu_player.max_db = lerp(tepastelu_player.max_db, -20.0, 1 - pow(0.1, delta))
	if GameState.game_started and not GameState.restart_game and not bgm.playing and not disable_bgm:
		bgm.play()
	if GameState.restart_game:
		bgm.stop()
		
func _input(event):
	if event is InputEventKey:
		if event.keycode == KEY_M and event.is_pressed():
			disable_bgm = !disable_bgm
			if not disable_bgm:
				bgm.play()
			else:
				bgm.stop()

func pickup():
	if not pipckup_player.playing or pipckup_player.get_playback_position() > 0.5:
		pipckup_player.play()

func crash():
	if not turpaan_player.playing or turpaan_player.get_playback_position() > 0.5:
		turpaan_player.play()
		tepastelu_player.max_db = -20.0
	
