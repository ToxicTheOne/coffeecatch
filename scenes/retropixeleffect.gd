extends ColorRect

@onready var self_material = self.material

func _ready():
	Autoload.player_touched.connect(rally_intensity)
	Autoload.end_buff.connect(chill_intensity)

func rally_intensity():
	self_material.set_shader_parameter("shake", 0.05)
	self_material.set_shader_parameter("pixelSize", 600)
	self_material.set_shader_parameter("grainIntensity", 0.05)
	self_material.set_shader_parameter("noiseIntensity", 0.01)
	self_material.set_shader_parameter("colorOffsetIntensity", 0.5)

func chill_intensity():

	self_material.set_shader_parameter("shake", 0.015)
	self_material.set_shader_parameter("pixelSize", 700)
	self_material.set_shader_parameter("grainIntensity", 0.01)
	self_material.set_shader_parameter("noiseIntensity", 0.001)
	self_material.set_shader_parameter("colorOffsetIntensity", 0.2)
