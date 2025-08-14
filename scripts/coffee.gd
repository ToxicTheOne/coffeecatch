extends RigidBody3D

@export var coffee_types := ["speedbuff", "slowbuff","invincibilitybuff","jumpbuff", "smallbuff"]
@export var coffee_speed := -1.4
@export var coffee_type : String
@onready var white_mug := $"White Mug"
@onready var green_mug := $"Green Mug"
@onready var purple_mug := $"Purple Mug"
@onready var red_mug := $"Red Mug"
@onready var blue_mug := $"Blue Mug"
@onready var mugs : Array = [white_mug, green_mug, purple_mug, red_mug, blue_mug]



func initialize_coffee():
	randomize_type()
	skew_position()
	apply_model()


func apply_model():
	for mug in mugs:
		mug.visible = false
	
	match coffee_type:
		"speedbuff":
			white_mug.visible = true
		"slowbuff":
			blue_mug.visible = true
		"invincibilitybuff":
			red_mug.visible = true
		"jumpbuff":
			green_mug.visible = true
		"smallbuff":
			purple_mug.visible = true

func randomize_type():
	coffee_type = coffee_types[randi_range(0,4)]

func skew_position():
	position.x += randi_range(-10, -40)
	position.z += randi_range(-5, 10)
	if Autoload.skew_harder == false:
		position.y += randi_range(0, 2)
	else:
		position.y += randi_range(0, 6)


func _physics_process(delta: float) -> void:
	position.x += coffee_speed
	self.rotation.z += 0.6

func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.is_in_group("player"):
		Autoload.score += 20
		Autoload.coffee_type = coffee_type
		Autoload.player_touched.emit()
		Autoload.coffee_taken += 1
		queue_free()
