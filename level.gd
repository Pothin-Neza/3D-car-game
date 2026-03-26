extends Node3D

# This variable tracks how many times you've crossed
var lap_count: int = 0
# Set this to 2 (or 3, or 10!) depending on your race rules
var total_laps_required: int = 3

func _on_area_3d_body_entered(body: Node3D) -> void:
	# 1. Check if the object is the player
	if body.name == "PlayerCar":
		lap_count += 1
		print("Lap crossed! Current laps: ", lap_count)
		
		# 2. Check if we've reached the finish goal
		if lap_count >= total_laps_required:
			finish_race()

func finish_race() -> void:
	print("Race Finished after 2 laps!")
	
	# Update the global data
	#if "is_race_completed" in GameData:
		#GameData.is_race_completed = true
	
	# Small delay then switch scenes
	await get_tree().create_timer(0.3).timeout
	get_tree().change_scene_to_file("res://race_completed.tscn")
