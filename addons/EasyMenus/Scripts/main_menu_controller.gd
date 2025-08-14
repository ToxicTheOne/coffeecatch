extends Control
signal start_game_pressed

@onready var start_game_button: Button = $%StartGameButton
@onready var options_menu: Control = $%OptionsMenu
@onready var content: Control = $%Content 
@onready var animation_player = $AnimationPlayer
@onready var whitemug: TextureRect = $Whitemug
@onready var color_rect: ColorRect = $ColorRect2
@onready var coffee_catch: Label = $CoffeeCatch


func _ready():
	start_game_button.grab_focus()
	animation_player.play("float")






func quit():
	get_tree().quit()

func open_options():
	color_rect.visible = false
	coffee_catch.visible = false
	whitemug.visible = false
	
	options_menu.show()
	content.hide()
	options_menu.on_open()
	
func close_options():
	color_rect.visible = true
	coffee_catch.visible = true
	whitemug.visible = true
	content.show();
	start_game_button.grab_focus()
	options_menu.hide()


func _on_start_game_button_pressed():
	emit_signal("start_game_pressed")
	get_tree().change_scene_to_file("res://scenes/gameplayscene.tscn")
