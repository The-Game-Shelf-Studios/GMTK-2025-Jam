extends Control

func _ready() -> void:
	 # Replace with function body.
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass



func _on_start_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Levels/TilesetExperiment.tscn")
	pass # Replace with function body.
