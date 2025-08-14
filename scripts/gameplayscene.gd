extends Node3D

@onready var pause_scene = get_node("PauseMenu")
var paused : bool = false
@onready var song: AudioStreamPlayer = $song


func _ready():
	pause_scene.close_pause_menu()
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	pause_scene.resume.connect(resume_pressed)
	song.play()

func _process(delta):
	if Input.is_action_just_pressed("pause"):
		paused =! paused
	if paused == true:
		pause_scene.open_pause_menu()
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	elif paused == false and Autoload.kill_player == false:
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
		pause_scene.close_pause_menu()
	elif paused == false:
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		song.stop()

func resume_pressed():
	paused = false
