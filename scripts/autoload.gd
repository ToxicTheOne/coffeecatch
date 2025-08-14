extends Node

signal player_touched
signal increase_score(score)
signal end_buff


@onready var coffee_taken : int
@onready var time_passed : String
@export var stats_increased : bool 
@export var coffee_score_increment := 20
@onready var score : int
@onready var seconds : int
@onready var coffee_type : String
@onready var player_velocity
@onready var skew_harder := false
@onready var kill_player := false
@onready var get_harder := false
@onready var kill_first_spawners := false

func _ready():
	await get_tree().create_timer(70).timeout
	kill_first_spawners = true
	get_harder = true
	await get_tree().create_timer(40).timeout
	skew_harder = true


func reset_score():
	score = 0
	seconds = 0
	skew_harder = false
