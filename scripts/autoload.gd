extends Node

signal player_touched
signal increase_score(score)
signal end_buff

@onready var time_passed : String
@export var stats_increased : bool 
@export var coffee_score_increment := 20
@onready var score : int
@onready var seconds : int
@onready var coffee_type : String
@onready var player_velocity
