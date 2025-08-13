extends RichTextLabel

@onready var secondslabel = $timelabel
@onready var timer = $scoretimer
@onready var seconds := 0
@onready var minutes := 0
@onready var sixty_seconds_count := 0

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

func _on_scoretimer_timeout() -> void:
	calculate_time()
