extends VehicleBody3D

# drag your two front wheels into these in the Inspector
@export var wheel_front_left  : VehicleWheel3D
@export var wheel_front_right : VehicleWheel3D

@export var max_steer  : float = 0.4
@export var steer_speed: float = 15.0

func _physics_process(delta):
	# ── Steering ──────────────────────────────────
	var steer_input = Input.get_axis("steer_right", "steer_left")
	var target = steer_input * max_steer
	
	var smooth = lerp(wheel_front_left.steering, target, steer_speed * delta)
	wheel_front_left.steering  = smooth
	wheel_front_right.steering = smooth

	# ── Engine ────────────────────────────────────
	var engine_input = Input.get_axis("move_forward", "move_backward")
	engine_force = engine_input * 300
