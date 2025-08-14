extends Node3D

@onready var pause_scene = get_node("PauseMenu")
var paused : bool = false

func _ready():
	pause_scene.close_pause_menu()
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	pause_scene.resume.connect(resume_pressed)

func _process(delta):
	if Input.is_action_just_pressed("pause"):
		paused =! paused
	if paused == true:
		pause_scene.open_pause_menu()
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	elif paused == false:
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
		pause_scene.close_pause_menu()



func resume_pressed():
	paused = false
