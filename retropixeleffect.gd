extends ColorRect

@onready var self_material = self.material
var tween1
var tween2

func _ready():
	Autoload.player_touched.connect(rally_intensity)
	Autoload.end_buff.connect(chill_intensity)

func rally_intensity():
	tween1 = get_tree().create_tween()
	tween1.tween_property(self_material, "shader_parameter/shake", 0.016, 0.2).set_trans(Tween.TRANS_QUAD)
	tween1.tween_property(self_material, "shader_parameter/pixelSize", 600, 0.2).set_trans(Tween.TRANS_QUAD)
	tween1.tween_property(self_material, "shader_parameter/grainIntensity", 0.02, 0.2).set_trans(Tween.TRANS_QUAD)
	tween1.tween_property(self_material, "shader_parameter/noiseIntensity", 0.002, 0.2).set_trans(Tween.TRANS_QUAD)
	tween1.tween_property(self_material, "shader_parameter/colorOffsetIntensity", 0.3, 0.2).set_trans(Tween.TRANS_QUAD)
	if tween2 != null:
		tween2.kill()

func chill_intensity():
	tween2 = get_tree().create_tween()
	tween2.tween_property(self_material, "shader_parameter/shake", 0.015, 0.1).set_trans(Tween.TRANS_QUAD)
	tween2.tween_property(self_material, "shader_parameter/pixelSize", 700, 0.1).set_trans(Tween.TRANS_QUAD)
	tween2.tween_property(self_material, "shader_parameter/grainIntensity", 0.01, 0.1).set_trans(Tween.TRANS_QUAD)
	tween2.tween_property(self_material, "shader_parameter/noiseIntensity", 0.001, 0.1).set_trans(Tween.TRANS_QUAD)
	tween2.tween_property(self_material, "shader_parameter/colorOffsetIntensity", 0.2, 0.1).set_trans(Tween.TRANS_QUAD)
	tween1.kill()
