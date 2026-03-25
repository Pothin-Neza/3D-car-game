extends Node3D

@onready var best_lap_label = $CanvasLayer/Control/CrashPanel/VBoxContainer/LabelBestLap
@onready var retry_btn = $CanvasLayer/Control/CrashPanel/VBoxContainer/RetryButton
@onready var home_btn = $CanvasLayer/Control/CrashPanel/VBoxContainer/HomeButton

func _ready():
	retry_btn.pressed.connect(_on_retry)
	home_btn.pressed.connect(_on_home)
	
	best_lap_label.text = "Best Lap: " + GameData.best_lap

func _on_retry():
	get_tree().change_scene_to_file("res://your_game_scene.tscn")

func _on_home():
	get_tree().change_scene_to_file("res://home.tscn")
