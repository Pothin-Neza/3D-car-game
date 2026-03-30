extends Node3D

@onready var third_person_cam : Camera3D = $ThirdPersonCam
@onready var driver_cam       : Camera3D = $DriverCam

func _ready():
	third_person_cam.current = true
	driver_cam.current = false

func _input(event):
	if Input.is_action_pressed("cameraSwitch"):  
		print("C pressed")  
		if third_person_cam.current == true :
			third_person_cam.current = false
			driver_cam.current       = true
		elif third_person_cam.current == false:
			third_person_cam.current = true
			driver_cam.current = false
