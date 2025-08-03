class_name PlayUI extends CanvasLayer

@onready var h_box_container: HBoxContainer = $HBoxContainer

func _ready() -> void:
	GameManager.play_ui = self
	
