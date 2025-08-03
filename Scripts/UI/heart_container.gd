class_name HeartBar extends HBoxContainer

var heart_full = preload("res://Sprites/Assets/Hearts/heart_sharp.png")
var heart_empty = preload("res://Sprites/Assets/Hearts/heart_sharp_empty.png")

var current_hearts : int
var max_hearts : int = 3

func _ready() -> void:
	GameManager.heart_bar = self

func update_health(value : int) -> void:
	for i in get_child_count():
		if value > i:
			get_child(i).texture = heart_full
		else:
			get_child(i).texture = heart_empty
