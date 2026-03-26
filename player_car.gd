extends VehicleBody3D

@export var max_steer   : float = 1
@export var steer_speed : float = 60.0
@export var restitution : float = 0.6

var bounce_timer : float = 0.0  # counts down after a bounce

func _physics_process(delta):
	# Steering
	var steer_input = Input.get_axis("steer_right", "steer_left")
	var target = steer_input * max_steer
	steering = move_toward(steering, target, steer_speed * delta)

	# Count the timer down every frame
	if bounce_timer > 0:
		bounce_timer -= delta
		engine_force = 0        
	else:
		var engine_input = Input.get_axis("move_forward", "move_backward")
		engine_force = engine_input * 600

func _integrate_forces(state: PhysicsDirectBodyState3D):
	for i in state.get_contact_count():
		var normal = state.get_contact_local_normal(i)
		if normal.y > 0.7:
			continue

		var vel = state.linear_velocity
		var reflected = vel - 2.0 * vel.dot(normal) * normal
		state.linear_velocity = reflected * restitution

		bounce_timer = 0.2    
