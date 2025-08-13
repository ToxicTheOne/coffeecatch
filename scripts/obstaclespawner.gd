extends Node3D

@onready var coffee_object = preload("res://scenes/coffee.tscn")
@onready var obstacle1 = preload("res://scenes/block.tscn")
@onready var obstacle2 = preload("res://scenes/sectionblock.tscn")
@onready var obstacle3
@onready var timer = $coffeetimer

var can_spawn_obstacles = true


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	timer.wait_time = randi_range(1,10)
	timer.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if can_spawn_obstacles:
		spawn_obstacle1()
		var chance_spawn = randi_range(1,30)
		if chance_spawn == 1:
			spawn_obstacle2()
	
	
	
	position.x += 0.19

func spawn_coffee():
	var new_coffee = coffee_object.instantiate()
	add_child(new_coffee)
	new_coffee.initialize_coffee()
	
	timer.wait_time = randi_range(1,10)
	timer.start()


func spawn_obstacle1():
	can_spawn_obstacles = false
	await get_tree().create_timer(randf_range(0.5,3)).timeout
	var new_obstacle1 = obstacle1.instantiate()
	add_child(new_obstacle1)
	new_obstacle1.randomize_scale()
	await get_tree().create_timer(randf_range(0.2,1)).timeout
	can_spawn_obstacles = true

func spawn_obstacle2():
	can_spawn_obstacles = false
	await get_tree().create_timer(randf_range(4,6)).timeout
	var new_obstacle2 = obstacle2.instantiate()
	add_child(new_obstacle2)
	print(str(new_obstacle2.normal_speed))
	new_obstacle2.position.y += 10
	await get_tree().create_timer(randf_range(1,3)).timeout
	can_spawn_obstacles = true



func _on_coffeetimer_timeout() -> void:
	var random = randi_range(0,1)
	if random == 1:
		spawn_coffee()
	else:
		return
