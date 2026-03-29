extends Node3D

@onready var lives_container  = $CountdownUI/LivesContainer
@onready var timer_label      = $CanvasLayer/TimerLabel
@onready var lap_label        = $CanvasLayer/LapLabel
@onready var background_music = $BackgroundMusic
@onready var lap_sound        = $LapSound

var lap_count           : int   = 0
var total_laps_required : int   = 3
var elapsed_time        : float = 0.0
var lap_start_time      : float = 0.0
var checkpoint_passed   : bool  = false

func _ready():
	GameData.lives     = 4
	GameData.is_racing = true
	update_lives_ui()
	lap_label.text = "LAP: 1/" + str(total_laps_required)

func _process(delta):
	if GameData.is_racing:
		elapsed_time += delta
		timer_label.text = format_time(elapsed_time)

func format_time(seconds: float) -> String:
	var mins = int(seconds) / 60
	var secs = int(seconds) % 60
	var ms   = int(fmod(seconds, 1.0) * 100)
	return "%02d:%02d:%02d" % [mins, secs, ms]

func update_lives_ui():
	if not lives_container: return
	var children = lives_container.get_children()
	for i in range(children.size()):
		children[i].visible = i < GameData.lives

func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.name == "PlayerCar":
		if not checkpoint_passed:
			print("Lap invalid - missed checkpoint!")
			return

		checkpoint_passed = false
		var lap_time = elapsed_time - lap_start_time
		lap_start_time = elapsed_time

		if GameData.best_lap == "00:00":
			GameData.best_lap = format_time(lap_time)
		else:
			if lap_time < float(GameData.best_lap.replace(":", "")):
				GameData.best_lap = format_time(lap_time)

		lap_sound.play()
		lap_count += 1
		print("Lap %d done in %s" % [lap_count, format_time(lap_time)])
		var display_lap = min(lap_count + 1, total_laps_required)
		lap_label.text = "LAP: " + str(display_lap) + "/" + str(total_laps_required)

		if lap_count >= total_laps_required:
			finish_race()

func finish_race() -> void:
	GameData.is_racing   = false
	GameData.finish_time = format_time(elapsed_time)
	background_music.stop()
	await get_tree().create_timer(1.1).timeout
	get_tree().change_scene_to_file("res://race_completed.tscn")

func _on_checkpoint_1_body_entered(body: Node3D) -> void:
	if body.name == "PlayerCar":
		checkpoint_passed = true
		print("Checkpoint passed!")

func _on_checkpoint_2_body_entered(body: Node3D) -> void:
	if body.name == "PlayerCar":
		checkpoint_passed = true
		print("Checkpoint passed!")
