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
	Autoload.time_passed = secondslabel.text
	
	if Autoload.kill_player == true:
		hide()
	
	

func update_label():
	self.text = str(" Score: ", Autoload.score)
	if seconds < 10:
		secondslabel.text = str(" Time: 0", minutes, ":0", seconds)

	elif seconds >= 10:
		secondslabel.text = str(" Time: 0", minutes, ":", seconds)


func calculate_time():
	if Autoload.kill_player == false:
		seconds += 1
		Autoload.score += 2
		sixty_seconds_count += 1
		if sixty_seconds_count == 60:
			minutes += 1
			sixty_seconds_count = 0
			seconds = 0


func update_announcer():
	var main_phrase : String
	var stats_increase_phrase : String
	
	if Autoload.stats_increased == true:
		stats_increase_phrase = "also +1 speed!"
	elif Autoload.stats_increased == false:
		stats_increase_phrase = ""
	
	var coffee_type = Autoload.coffee_type
	match coffee_type:
		"speedbuff":
			main_phrase = str("Coffee Aquired! 'Speed' buff! \n", stats_increase_phrase)
		"slowbuff":
			main_phrase = str("Coffee Aquired! 'Slow-motion' buff! \n", stats_increase_phrase)
		"invincibilitybuff":
			main_phrase = str("Coffee Aquired! 'Sinking' buff! \n", stats_increase_phrase)
		"jumpbuff":
			main_phrase = str("Coffee Aquired! 'Jump' buff! \n", stats_increase_phrase)
		"smallbuff":
			main_phrase = str("Coffee Aquired! 'Small' buff! \n", stats_increase_phrase)
		null:
			print("coffee_type not found, couldnt update label. this print is in the Label script")
	
	var tween = get_tree().create_tween()
	
	tween.tween_property(announcer, "scale", Vector2(0, 0), 0.05 ).set_trans(Tween.TRANS_LINEAR)
	announcer.text = main_phrase

	
	tween.tween_property(announcer, "scale", Vector2(1, 1), 0.2 ).set_trans(Tween.TRANS_QUINT).set_ease(Tween.EASE_IN)
	
	await get_tree().create_timer(3).timeout

	tween = get_tree().create_tween()
	tween.tween_property(announcer, "scale", Vector2(0, 0), 0.3 ).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_QUINT)
	
	await get_tree().create_timer(0.6).timeout
	announcer.text = ""



func _on_scoretimer_timeout() -> void:
	calculate_time()
