extends VehicleBody3D

@export var max_steer    : float = 0.5
@export var steer_speed  : float = 3.0
@export var engine_power : float = 400.0
@export var restitution  : float = 0.9

var bounce_timer   : float = 0.0
var crash_cooldown : float = 0.0
var prev_speed     : float = 0.0

@onready var engine_sound = $EngineSound
@onready var crash_sound  = $CrashSound

func _ready():
	contact_monitor = true
	max_contacts_reported = 10
	engine_sound.play()

func _process(_delta):
	engine_sound.pitch_scale = clamp(0.6 + linear_velocity.length() * 0.05, 0.6, 2.0)

func _physics_process(delta):
	var steer_input = Input.get_axis("steer_right", "steer_left")
	var target = steer_input * max_steer
	steering = lerp(steering, target, steer_speed * delta)

	if bounce_timer > 0:
		bounce_timer -= delta
		engine_force = 0
	else:
		var engine_input = Input.get_axis("move_forward", "move_backward")
		engine_force = engine_input * engine_power

	if crash_cooldown > 0:
		crash_cooldown -= delta

func _integrate_forces(state: PhysicsDirectBodyState3D):
	var vel = state.linear_velocity
	var speed = vel.length()

	if prev_speed > 5.0 and (prev_speed - speed) > 4.0:
		if crash_cooldown <= 0:
			GameData.lives -= 1
			crash_cooldown = 1.5
			crash_sound.play()

			var level = get_tree().current_scene
			if level.has_method("update_lives_ui"):
				level.call_deferred("update_lives_ui")

			if GameData.lives <= 0:
				get_tree().call_deferred("change_scene_to_file", "res://game_over.tscn")

		bounce_timer = 0.3

	prev_speed = speed
