extends Node3D

# Matches the typo in your scene tree exactly
@onready var lives_container = $CountdownUI/LivesContainer

var lap_count: int = 0
var total_laps_required: int = 3

func _ready():
	# Initialize lives in the global singleton
	GameData.lives = 4
	update_lives_ui()

# This is the function the car will call when it crashes
func update_lives_ui():
	if not lives_container: return
	
	var children = lives_container.get_children()
	for i in range(children.size()):
		# Show the lightning bolt only if its index is less than current lives
		children[i].visible = i < GameData.lives

func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.name == "PlayerCar":
		lap_count += 1
		print("Lap crossed! Current laps: ", lap_count)
		
		if lap_count >= total_laps_required:
			finish_race()

func finish_race() -> void:
	print("Race Finished!")
	await get_tree().create_timer(0.3).timeout
	get_tree().change_scene_to_file("res://race_completed.tscn")
