extends AnimationPlayer

func _ready():
	play("intro")

func start_game():
	print("GameState.game_started: ", GameState.game_started)
	GameState.game_started = true
