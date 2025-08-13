extends RichTextLabel

@onready var secondslabel = $timelabel
@onready var timer = $scoretimer
@onready var announcer = $announcer
@onready var seconds := 0
@onready var minutes := 0
@onready var sixty_seconds_count := 0


func _ready():
	Autoload.player_touched.connect(update_announcer)

func _process(delta):
	update_label()


func update_label():
	self.text = str(" Score: ", Autoload.score)
	secondslabel.text = str(" Time: ", minutes, ":", seconds)



func calculate_time():
	seconds += 1
	Autoload.score += 2
	sixty_seconds_count += 1
	if sixty_seconds_count == 60:
		minutes += 1
		sixty_seconds_count = 0
		seconds = 0


func update_announcer():
	var main_phrase : String
	var stats_increase_phrase : String = "Also +1 speed & +1 jump force!"
	var coffee_type = Autoload.coffee_type
	match coffee_type:
		"speedbuff":
			main_phrase = str("Coffee Aquired! 'Speed' buff! ", stats_increase_phrase)
		"slowbuff":
			main_phrase = str("Coffee Aquired! 'Slow-motion' buff! ", stats_increase_phrase)
		"invincibilitybuff":
			main_phrase = str("Coffee Aquired! 'Sinking' buff! ", stats_increase_phrase)
		"jumpbuff":
			main_phrase = str("Coffee Aquired! 'Jump' buff! ", stats_increase_phrase)
		"smallbuff":
			main_phrase = str("Coffee Aquired! 'Small' buff! ", stats_increase_phrase)
	announcer.text = main_phrase
	



func _on_scoretimer_timeout() -> void:
	calculate_time()
