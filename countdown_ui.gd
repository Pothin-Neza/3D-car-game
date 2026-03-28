extends CanvasLayer # Or whatever node type CountdownUI is

# 1. This "creates the phone line" your level script is listening to
signal race_started

func start_countdown():
	# ... your countdown logic (3, 2, 1) ...
	
	# 2. This "makes the call" to the level script
	race_started.emit()
	hide() # Hide the UI when the race starts
