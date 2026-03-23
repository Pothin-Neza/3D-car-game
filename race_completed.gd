extends Node3D

@onready var time_label = $CanvasLayer/Control/RaceCompletePanel/VBoxContainer/LabelTime
@onready var best_lap_label = $CanvasLayer/Control/RaceCompletePanel/VBoxContainer/LabelBestLap
@onready var play_again_btn = $CanvasLayer/Control/RaceCompletePanel/VBoxContainer/ButtonPlayAgain
@onready var home_btn = $CanvasLayer/Control/RaceCompletePanel/VBoxContainer/ButtonHome

func _ready():
	play_again_btn.pressed.connect(_on_play_again)
	home_btn.pressed.connect(_on_home)
	
	time_label.text = "Finish Time: " + GameData.finish_time
	best_lap_label.text = "Best Lap: " + GameData.best_lap

func _on_play_again():
	get_tree().change_scene_to_file("res://your_game_scene.tscn")

func _on_home():
	get_tree().change_scene_to_file("res://home.tscn")
