extends CanvasLayer

@onready var label = $CountdownLabel

var active_tween : Tween 

func _ready():
	label.text = ""
	start_countdown()

func start_countdown():
	
	animate_text("3", Color.html("#d90429")) 
	await get_tree().create_timer(1.0).timeout
	animate_text("2", Color.html("#f77f00")) 
	await get_tree().create_timer(1.0).timeout
	
	animate_text("1", Color.html("#fcbf49")) 
	await get_tree().create_timer(1.0).timeout
	
	
	animate_text("GO!", Color.html("#32CD32")) 
	get_parent().can_move = true 
	
	await get_tree().create_timer(1.5).timeout
	label.hide()

func animate_text(new_text: String, color_choice: Color):
	
	if active_tween and active_tween.is_valid():
		active_tween.kill()
		
	label.show()
	label.text = new_text
	
	label.modulate = color_choice 
	label.modulate.a = 1.0 
	label.scale = Vector2(0.5, 0.5) 
	label.pivot_offset = label.size / 2 
	
	
	active_tween = create_tween().set_parallel(true)
	active_tween.tween_property(label, "scale", Vector2(1.5, 1.5), 0.4).set_trans(Tween.TRANS_BOUNCE)
	
	active_tween.tween_property(label, "modulate:a", 0.0, 0.4).set_delay(0.5)
