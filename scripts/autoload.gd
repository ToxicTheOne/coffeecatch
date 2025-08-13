extends Node

signal player_touched
signal increase_score(score)
signal end_buff


@export var stats_increased : bool = false
@export var coffee_score_increment := 20
@onready var score : int
@onready var seconds : int
@onready var coffee_type : String
