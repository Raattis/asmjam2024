extends Node

const car_scene := preload("res://car.tscn")
const lane_markers := preload("res://many_lane_markers.tscn")
const grass = preload("res://grass.tscn")
const nuggets = preload("res://gfx/nugettipaketti/nuggets.tscn")
var lanes := {}

func spawn_lane(lane_index: int):
	lanes[lane_index] = []
	
	var speed : float = clamp(50.0 + lane_index * 0.5, 1.0, 300.0)
	var progress : float = lane_index * 1.0 / GameState.lane_count
	
	if lane_index >= 0 and lane_index <= 76:
		var lane : LaneMarkers = lane_markers.instantiate()
		lane.progress_position = progress - GameState.lane_width * 0.5
		lane.position.y = 100000
		add_child(lane)
		lanes[lane_index].append(lane)
	else:
		var gr : LaneMarkers = grass.instantiate()
		gr.progress_position = progress - GameState.lane_width * 0.5
		gr.position.y = 100000
		add_child(gr)
		lanes[lane_index].append(gr)

	if lane_index < 0 or lane_index > 75:
		return
	
	var nug_random := RandomNumberGenerator.new()
	if lane_index % 5 == 0 and not lane_index in GameState.nugs_eaten:
		var nugs : Node3D = nuggets.instantiate()
		nugs.progress_position = progress + GameState.lane_width * 0.2 * nug_random.randf_range(-1,1)
		nugs.lane_index = lane_index
		nugs.position.y = 10000
		nugs.position.x = nug_random.randf_range(-25.0, 25.0)
		add_child(nugs)
		lanes[lane_index].append(nugs)
	
	var spawn_random := RandomNumberGenerator.new()
	spawn_random.seed = lane_index
	var offset := spawn_random.randf_range(0, GameState.terrain_scale.x)
	for j in range(spawn_random.randi_range(1 + 155 / speed, 6 + progress)):
		var car := car_scene.instantiate()
		car.progress_position = progress + GameState.lane_width * 0.1 * spawn_random.randf_range(-1, 1)
		car.speed = speed
		offset += car.get_node("MeshInstance3D").scale.z * spawn_random.randf_range(1.75, 2.0)
		car.position.x += fmod(offset, GameState.terrain_scale.x * 1.0) - GameState.terrain_scale.x * 0.5
		car.position.y = 10000
		add_child(car)
		if lane_index % 2 == 0:
			car.speed *= -1
		lanes[lane_index].append(car)

func _process(delta):
	var current_lane_index := int(GameState.progress / GameState.lane_width)
	const first_visible := -5
	const last_visible := 3
	for lane_index in range(current_lane_index + first_visible, current_lane_index + last_visible):
		if not lane_index in lanes:
			spawn_lane(lane_index)
	for lane_index in range(current_lane_index + first_visible - 10, current_lane_index + first_visible):
		if lane_index in lanes:
			for lane in lanes[lane_index]:
				if lane and is_instance_valid(lane):
					lane.queue_free()
			lanes.erase(lane_index)
