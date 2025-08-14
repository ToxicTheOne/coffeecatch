extends Control


@onready var dead: Label = $"Dead!"
@onready var scorelabel: Label = $score
@onready var timelabel: Label = $time
@onready var coffee_dranklabel: Label = $coffee_drank
@onready var color_rect: ColorRect = $ColorRect
@onready var back_to_menu_button: Button = $BackToMenuButton



func ready():
	hide()
	dead.visible = false
	scorelabel.visible = false
	timelabel.visible = false
	coffee_dranklabel.visible = false




func _process(delta):
	if Autoload.kill_player == true:
		end_game()



func end_game():
	scorelabel.text = str("Score: ", Autoload.score)
	timelabel.text = str("Time: ", Autoload.time_passed)
	coffee_dranklabel.text = str("Coffees Drank: ", Autoload.coffee_taken)
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	show()
	dead.visible = true
	scorelabel.visible = true
	timelabel.visible = true
	coffee_dranklabel.visible = true
	
	if Input.is_action_pressed("pause"):
		get_tree().change_scene_to_file("res://addons/EasyMenus/Scenes/main_menu.tscn")
		Autoload.kill_player = false
		Autoload.reset_score()

func _on_back_to_menu_button_pressed() -> void:
	get_tree().change_scene_to_file("res://addons/EasyMenus/Scenes/main_menu.tscn")
	Autoload.kill_player = false
	Autoload.reset_score()
