extends StaticBody3D


var speed = 0.01
var speed_gain_chance
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.x += speed
	speed_gain_chance = randi_range(1,300)
	if speed_gain_chance == 1 and speed < 0.17:
		speed += 0.01
		speed_gain_chance = randi_range(1,1000)
		print ("speed gained!", speed)
