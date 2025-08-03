extends Node

enum GAMEMODE { PLAY , PAUSE , MENU , GAMEOVER }
var current_gamemode : GAMEMODE = GAMEMODE.MENU ## For testing purposes this is PLAY
const PAUSE_MENU = preload("res://Scenes/UI/pause_menu.tscn")

var player : Player
var heart_bar : HeartBar
var enemies = []
var play_ui : CanvasLayer
var pause_menu : CanvasLayer

func _ready() -> void:
	_init()
	print("Ready has run")

func _init() -> void:
	if current_gamemode == GAMEMODE.MENU:
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		pass
	elif current_gamemode == GAMEMODE.PLAY:
		Input.mouse_mode = Input.MOUSE_MODE_HIDDEN
		for i in get_tree().current_scene.get_children():
			if i.is_in_group("Enemy"):
				enemies.append(i)
		print(enemies.size() , " enemies")
		
func _process(delta: float) -> void:
	pass

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("Pause"):
		pause_game()

func pause_game() -> void:
	if current_gamemode == GAMEMODE.PLAY:
		play_ui.visible = false
		pause_menu.visible = true
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		current_gamemode = GAMEMODE.PAUSE
		get_tree().paused = true
	elif current_gamemode == GAMEMODE.PAUSE:
		Input.mouse_mode = Input.MOUSE_MODE_HIDDEN
		pause_menu.visible = false
		play_ui.visible = true
		current_gamemode = GAMEMODE.PLAY

#func _on_unpause() -> void:
	

func scene_transition(new_scene : String) -> void:
	if new_scene == "Menu":
		get_tree().change_scene_to_file("res://Scenes/Menus/main_menu.tscn")
		current_gamemode = GAMEMODE.MENU
	elif new_scene == "Play":
		get_tree().change_scene_to_file("res://Scenes/Levels/TilesetExperiment.tscn")
		current_gamemode = GAMEMODE.PLAY


func quit_game() -> void:
	get_tree().quit()
