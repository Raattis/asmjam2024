extends Node3D

const START = preload("res://main.tscn")
const MAIN = preload("res://main.tscn")
const END = preload("res://main.tscn")
var prev_gamme_started := false
var prev_gamme_ended := false
var prev_gamme_restarted := false

func _ready():
	$animation_player.play("game_fade_in")
	print("game_fade_in")

func _process(delta):
	if GameState.ended and not prev_gamme_ended:
		prev_gamme_ended = true
		$animation_player.play("end_game")
		print("end_game")
	if GameState.game_started and not prev_gamme_started:
		prev_gamme_started = true
		$animation_player.play("start_game")
		print("start_game")
	if GameState.restart_game and not prev_gamme_restarted:
		prev_gamme_restarted = true
		$animation_player.play("restart_game")
		print("restart_game")

func load_main_scene():
	get_tree().change_scene_to_packed(MAIN)

func load_end_scene():
	pass #get_tree().change_scene_to_packed(END)

func restart_game():
	GameState.restart_game_now()
	get_tree().change_scene_to_file("res://main.tscn")
