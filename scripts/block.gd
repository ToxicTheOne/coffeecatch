extends RigidBody3D

class_name obstacle


@export var normal_speed : float = -1.8 # -0.7
var speed : float = normal_speed
@onready var collision : CollisionShape3D 
@onready var mesh : MeshInstance3D 
@export var slow_buff := false
@export var invincible_buff := false
@export var small_buff := false
@export var small_immunity := false
@export var randomize_velocity := true

func apply_debuff():
	print("apply_debuff")
	var coffee_type = Autoload.coffee_type
	match coffee_type:
		"invincibilitybuff":
			print("invincibility")
			invincible_buff = true
		"slowbuff":
			print("slowbuff")
			slow_buff = true
		"smallbuff":
			print("smallbuff")
			small_buff = true
	
	deactivate_debuffs(coffee_type)
	return



func deactivate_debuffs(coffee_type):
	await get_tree().create_timer(5).timeout
	match coffee_type:
		"invincibilitybuff":
			Autoload.emit_signal("end_buff")
			invincible_buff = false
		"slowbuff":
			Autoload.emit_signal("end_buff")
			slow_buff = false
		"smallbuff":
			Autoload.emit_signal("end_buff")
			small_buff = false
	Autoload.emit_signal("end_buff")


func randomize_scale():
	visible = false
	collision = get_child(0)
	mesh = get_child(1)
	if small_buff == false:
		collision.scale = Vector3(randf_range(2,6),randf_range(2,8),randf_range(2,9))
	
	elif small_buff == true:
		collision.scale = Vector3(randf_range(1,3),randf_range(1,3),randf_range(1,3))
	
	mesh.scale = collision.scale
	
	if randomize_velocity == true:
		normal_speed = randf_range(-1.1, -1.8)
		speed = normal_speed
	
	await get_tree().create_timer(0.2).timeout
	visible = true

func _process(delta: float):
	if small_buff == true and small_immunity == false:
		collision.scale = Vector3(randf_range(1,2),randf_range(1,2),randf_range(1,3))
		mesh.scale = collision.scale
		
	if slow_buff == true:
		speed = -0.4
	elif slow_buff == false:
		speed = normal_speed
	
	if invincible_buff == false:
		position.x += speed
	elif invincible_buff == true:
		position.x += 0
		position.y -= 0.2








func _ready():
	Autoload.player_touched.connect(apply_debuff)
	await get_tree().create_timer(20).timeout
	queue_free()
	
	
	
