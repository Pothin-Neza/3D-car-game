extends VehicleBody3D

@export var wheel_front_left  : VehicleWheel3D
@export var wheel_front_right : VehicleWheel3D

@export var max_steer  : float = 0.4
@export var steer_speed: float = 15.0

@onready var engine_sound = $EngineSound
@onready var start_sound = $StartSound

var can_move : bool = false
var race_started_flag : bool = false 

func _physics_process(delta):

	var steer_input = Input.get_axis("steer_right", "steer_left")
	var target = steer_input * max_steer
	
	var smooth = lerp(wheel_front_left.steering, target, steer_speed * delta)
	wheel_front_left.steering  = smooth
	wheel_front_right.steering = smooth

	var engine_input = 0.0 
	
	if can_move:
		if not race_started_flag:
			if start_sound: 
				start_sound.play()
			race_started_flag = true
			
		engine_input = Input.get_axis("move_forward", "move_backward")
		engine_force = engine_input * 300
	else:
		engine_force = 0

	
	if engine_sound and race_started_flag:
		var speed = linear_velocity.length()
		
		
		if engine_input != 0:
			
			engine_sound.pitch_scale = 1.0 + (speed / 20.0)
			engine_sound.volume_db = 0.0 
		else:
			# If you let go of the keys, drop the pitch and muffle the volume
			engine_sound.pitch_scale = 0.7 + (speed / 40.0)
			# -10 dB makes it significantly quieter
			engine_sound.volume_db = -10.0
