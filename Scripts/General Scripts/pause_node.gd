extends Node

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("Pause"):
		if get_tree().paused:
			unpause_game()

func unpause_game() -> void:
	get_tree().paused = false
	GameManager.pause_game()
	pass
