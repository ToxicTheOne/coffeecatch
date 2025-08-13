extends RigidBody3D

class_name coffee

@export var coffee_types := ["speedbuff", "slowbuff","invincibilitybuff","jumpbuff", "smallbuff"]
@export var coffee_speed := -1.4
@export var coffee_type : String


func initialize_coffee():
	randomize_type()
	skew_position()

func randomize_type():
	coffee_type = coffee_types[randi_range(0,4)]

func skew_position():
	position.x += randi_range(-10, -40)
	position.z += randi_range(-5, 10)

func _physics_process(delta: float) -> void:
	position.x += coffee_speed


func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.is_in_group("player"):
		Autoload.score += 20
		Autoload.coffee_type = coffee_type
		Autoload.player_touched.emit()
		queue_free()


func _ready():
	await get_tree().create_timer(20).timeout
	queue_free()
