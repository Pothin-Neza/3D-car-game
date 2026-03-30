extends CanvasLayer 

signal race_started

func start_countdown():
	
	race_started.emit()
	hide() 
