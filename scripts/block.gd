extends RigidBody3D

class_name obstacle

@export var normal_speed : float = -0.7
var speed : float = normal_speed
@onready var collision : CollisionShape3D 
@onready var mesh : MeshInstance3D 
@export var slow_buff := false
@export var invincible_buff := false
@export var small_buff := false


func randomize_scale():
	visible = false
	collision = get_child(0)
	mesh = get_child(1)
	if small_buff == false:
		collision.scale = Vector3(randf_range(1,6),randf_range(1,8),randf_range(1,10))
	
	elif small_buff == true:
		collision.scale = Vector3(randf_range(1,2),randf_range(1,2),randf_range(1,3))
	
	mesh.scale = collision.scale
	await get_tree().create_timer(0.2).timeout
	visible = true

func _process(delta: float):
	if slow_buff == true:
		speed += 4
	elif slow_buff == false:
		speed = normal_speed
	
	
	if invincible_buff == false:
		position.x += speed

func _physics_process(delta: float):
	if invincible_buff == true:
		linear_velocity.x += speed
	
