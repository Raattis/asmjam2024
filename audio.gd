extends Node3D

@onready var tepastelu_player = $tepastelu_player
@onready var turpaan_player = $turpaan_player
@onready var pipckup_player = $pipckup_player
@onready var bgm = $bgm


func _ready():
	pass # Replace with function body.

func _process(delta):
	var chicken : Chicken = get_node("/root/Node3D/chicken")
	if chicken:
		if (abs(chicken.up_down) > 0 or abs(chicken.left_right) > 0) and (chicken.linear_velocity.length() > 1 or abs(GameState.progress_velocity) > 0.1):
			if not tepastelu_player.playing and not GameState.is_stunned():
				tepastelu_player.play()
	if GameState.game_started and not GameState.restart_game and not bgm.playing:
		bgm.play()
	if GameState.restart_game:
		bgm.stop()

func pickup():
	if not pipckup_player.playing or pipckup_player.get_playback_position() > 0.5:
		pipckup_player.play()

func crash():
	if not turpaan_player.playing or turpaan_player.get_playback_position() > 0.5:
		turpaan_player.play()
		tepastelu_player.stop()
	
