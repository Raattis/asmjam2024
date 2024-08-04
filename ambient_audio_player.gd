extends Node

const simultaneous_count = 5

var playing_streams: Array[AudioStreamPlayer] = [];

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if playing_streams.size() > 0:
		for i in range(playing_streams.size() - 1, 0, -1):
			if !playing_streams[i].playing:
				playing_streams.remove_at(i)
	
	if playing_streams.size() < simultaneous_count:
		var stream = pick_some_stream()
		if stream and !stream.playing:
			stream.play()
			playing_streams.push_back(stream)
			print("start stream " + stream.name)
	
func pick_some_stream() -> AudioStreamPlayer:
	return get_child(randi_range(0, get_child_count() - 1))
