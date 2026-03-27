extends VehicleBody3D

@export var max_steer    : float = 0.5
@export var steer_speed  : float = 3.0
@export var engine_power : float = 400.0
@export var restitution  : float = 0.9  # raised from 0.6 so bounces are visible

var bounce_timer : float = 0.0

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

func _integrate_forces(state: PhysicsDirectBodyState3D):
	for i in state.get_contact_count():
		var normal = state.get_contact_local_normal(i)

		if normal.y > 0.7:
			continue

		var vel = state.linear_velocity
		var speed = vel.length()
		
		# Don't bounce if barely moving
		if speed < 1.0:
			continue
			
		var impact = abs(vel.normalized().dot(normal))

		if impact > 0.7:
			# Perpendicular — slam back hard
			state.linear_velocity = -vel.normalized() * speed * restitution
			state.angular_velocity = Vector3.ZERO  # stop spinning
		else:
			# Glancing — reflect and slide
			var reflected = vel - 2.0 * vel.dot(normal) * normal
			state.linear_velocity = reflected * lerp(0.95, restitution, impact)

		# Push car away from wall so it doesn't stick
		state.linear_velocity += normal * 3.0
		bounce_timer = 0.3  # slightly longer freeze
