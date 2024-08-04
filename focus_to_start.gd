extends Node3D

func _notification(what):
	if what == MainLoop.NOTIFICATION_APPLICATION_FOCUS_IN:
		get_tree().change_scene_to_file("res://intro_scene.tscn")
	#elif what == MainLoop.NOTIFICATION_APPLICATION_FOCUS_OUT:
	#	print("focus out")

func _input(event):
	if event is InputEventAction and event.is_action_pressed():
		get_tree().change_scene_to_file("res://intro_scene.tscn")
	if event is InputEventMouseButton and event.is_pressed():
		get_tree().change_scene_to_file("res://intro_scene.tscn")
