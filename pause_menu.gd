extends CanvasLayer

func _ready() -> void:
	GameManager.pause_menu = self
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_resume_button_pressed() -> void:
	PauseNode.unpause_game()


func _on_exit_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Menus/main_menu.tscn")
	pass # Replace with function body.
