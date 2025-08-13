extends Node3D

@onready var coffee_object = preload("res://scenes/coffee.tscn")
@onready var obstacle1 = preload("res://scenes/block.tscn")
@onready var obstacle2 = preload("res://scenes/sectionblock.tscn")
@onready var obstacle3 = preload("res://scenes/jumpblock.tscn")
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
		var chance_spawn1 = randi_range(1,35)
		if chance_spawn1 == 1:
			spawn_obstacle2()
		var chance_spawn2 = randi_range(1,20)
		if chance_spawn2 == 1:
			spawn_obstacle3()
	
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
	await get_tree().create_timer(randf_range(2,4)).timeout
	var new_obstacle2 = obstacle2.instantiate()
	add_child(new_obstacle2)

	new_obstacle2.position.y += 1
	await get_tree().create_timer(randf_range(1,3)).timeout
	can_spawn_obstacles = true

func spawn_obstacle3():
	can_spawn_obstacles = false
	await get_tree().create_timer(randf_range(2,6)).timeout
	var new_obstacle3 = obstacle3.instantiate()
	add_child(new_obstacle3)
	new_obstacle3.position.y += 2
	await get_tree().create_timer(randf_range(1,2)).timeout
	can_spawn_obstacles = true




func _on_coffeetimer_timeout() -> void:
	var random = randi_range(0,1)
	if random == 1:
		spawn_coffee()
	else:
		return
