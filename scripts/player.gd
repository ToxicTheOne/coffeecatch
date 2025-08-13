extends CharacterBody3D

# Buffs
var jump_buff := false
var speed_buff := false

# Headbob
const BOB_FREQ := 2.0
const BOB_AMP := 0.08
var t_bob := 0.0

# Other stuff
@onready var camera: Camera3D = $Twistpivot/Camera3D
@onready var twistpivot: Node3D = $Twistpivot
var mouse_position
var current_speed = 10.0
var jump_velocity = 6
var walking_speed = 10.0
var crouching_speed = 3
var mouse_sens = 0.4

# FOV
const BASE_FOV = 75.0
const FOV_CHANGE = 1.5

# Dash
var dash_velocity = 37
var can_dash := true
var dashes := 3
# Camera
func _unhandled_input(event):
	if event is InputEventMouseMotion:
		twistpivot.rotate_y(deg_to_rad(-event.relative.x * mouse_sens))
		camera.rotate_x(deg_to_rad(-event.relative.y * mouse_sens))
		camera.rotation.x = clamp(camera.rotation.x,  deg_to_rad(-40), deg_to_rad(60))


func _process(delta):
	if dashes == 0:
		can_dash = false
	elif dashes > 0:
		can_dash = true
	if dashes > 3:
		dashes = 3
	elif dashes < 0:
		dashes = 0


func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	Autoload.player_touched.connect(apply_buff)


func apply_buff():
	var random_chance = randi_range(0,1)
	if random_chance == 1:
		current_speed += 1
		walking_speed += 1
		jump_velocity += 1
		Autoload.stats_increased = true
	var coffee_type = Autoload.coffee_type
	match coffee_type:
		"jumpbuff":
			jump_buff = true
		"speedbuff":
			speed_buff = true

	deactivate_buffs(coffee_type)



func deactivate_buffs(coffee_type):
	await get_tree().create_timer(5).timeout
	match coffee_type:
		"jumpbuff":
			Autoload.emit_signal("end_buff")
			jump_buff = false
		"speedbuff":
			Autoload.emit_signal("end_buff")
			speed_buff = false

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("move_jump") and is_on_floor():
		velocity.y = jump_velocity
		if jump_buff == true:
			velocity.y = jump_velocity * 1.8

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("move_left", "move_right", "move_forward", "move_backward")
	var direction := (twistpivot.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if is_on_floor():

		if direction:
			velocity.x = direction.x * current_speed
			velocity.z = direction.z * current_speed 
			if speed_buff == true:
				velocity.x = direction.x * current_speed * 1.8
				velocity.z = direction.z * current_speed * 1.8
		else:
			velocity.x = lerp(velocity.x, direction.x * current_speed, delta * 6)
			velocity.z = lerp(velocity.z, direction.z * current_speed, delta * 6)
	else:
		velocity.x = lerp(velocity.x, direction.x * current_speed, delta * 5)
		velocity.z = lerp(velocity.z, direction.z * current_speed, delta * 5)
		

	if Input.is_action_just_pressed("dash") and can_dash:
		var cam_direction = -twistpivot.transform.basis.z.normalized()
		velocity = cam_direction * dash_velocity
		velocity.y += 4
		if speed_buff == true:
			velocity = cam_direction * dash_velocity * 1.8
			velocity.y += 5
		elif jump_buff == true:
			velocity = cam_direction * dash_velocity * 1.2
			velocity.y += 8
		
		dashes -= 1
		
		await get_tree().create_timer(3).timeout
		dashes += 1
	
	
	t_bob += delta * velocity.length() * float(is_on_floor())
	camera.transform.origin = headbob(t_bob)
	
	
	var velocity_clamped = clamp(velocity.length(), 0.5, current_speed * 2)
	var target_fov = BASE_FOV + FOV_CHANGE * velocity_clamped
	camera.fov = lerp(camera.fov, target_fov, delta * 8.0)
	
	
	move_and_slide()


func headbob(t_bob):
	var pos = Vector3.ZERO
	pos.y = sin(t_bob * BOB_FREQ) * BOB_AMP
	pos.x = sin(t_bob * BOB_FREQ) / 2 * BOB_AMP
	return pos
