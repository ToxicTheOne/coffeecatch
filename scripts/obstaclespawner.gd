extends Node3D


@onready var obstacle1 = preload("res://scenes/block.tscn")
@onready var obstacle2
@onready var obstacle3
var can_spawn_obstacles = true


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if can_spawn_obstacles:
		spawn_obstacle()
	position.x += 0.1





func spawn_obstacle():
	can_spawn_obstacles = false
	await get_tree().create_timer(randf_range(0.5,3)).timeout
	var new_obstacle1 = obstacle1.instantiate()
	add_child(new_obstacle1)
	new_obstacle1.randomize_scale()
	await get_tree().create_timer(randf_range(0.2,1)).timeout
	can_spawn_obstacles = true
