extends Node

enum GAMEMODE { PLAY , PAUSE , MENU , GAMEOVER }
var current_gamemode : GAMEMODE = GAMEMODE.MENU ## For testing purposes this is PLAY

var player : Player
var heart_bar : HeartBar
var enemies = []
var play_ui : CanvasLayer
var pause_menu : CanvasLayer
var game_over_ui : CanvasLayer

var game_won := false
var game_over := false

func _ready() -> void:
	#initialize_scene()
	pass

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("Pause") && (GAMEMODE.PLAY || GAMEMODE.PAUSE):
		pause_game()

func _process(delta: float) -> void:
	if !game_over && player:
		if player.player_dead:
			game_over = true
			game_won = false
			current_gamemode = GAMEMODE.GAMEOVER
			pause_game()
		elif enemies.size() <= 0:
			game_over = true
			game_won = true
			current_gamemode = GAMEMODE.GAMEOVER
			pause_game()

func initialize_scene() -> void:
	if current_gamemode == GAMEMODE.MENU:
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		pass
	elif current_gamemode == GAMEMODE.PLAY:
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
		for i in get_tree().current_scene.get_children():
			if i.is_in_group("Enemy"):
				enemies.append(i)
		print(enemies.size() , " enemies")

func scene_transition(new_scene : String) -> void:
	if new_scene == "Menu":
		reset()
		current_gamemode = GAMEMODE.MENU
		get_tree().change_scene_to_file("res://Scenes/Menus/main_menu.tscn")
	elif new_scene == "Play":
		reset()
		current_gamemode = GAMEMODE.PLAY
		get_tree().change_scene_to_file("res://Scenes/Levels/TilesetExperiment.tscn")

func pause_game() -> void:
	if current_gamemode == GAMEMODE.PLAY:
		print("play")
		play_ui.visible = false
		pause_menu.visible = true
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		current_gamemode = GAMEMODE.PAUSE
		get_tree().paused = true
	elif current_gamemode == GAMEMODE.PAUSE:
		print("pause")
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
		pause_menu.visible = false
		play_ui.visible = true
		current_gamemode = GAMEMODE.PLAY
	elif current_gamemode == GAMEMODE.GAMEOVER:
		print("gameover")
		play_ui.visible = false
		game_over_ui.visible = true
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		get_tree().paused = true
	else:
		get_tree().paused = false

func reset() -> void:
	player = null
	enemies.clear()
	game_over = false
	game_won = false
	if get_tree().paused:
		get_tree().paused = false

func quit_game() -> void:
	get_tree().quit()
