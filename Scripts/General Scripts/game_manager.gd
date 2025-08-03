extends Node

enum GAMEMODE { PLAY , PAUSE , MENU , GAMEOVER }
var current_gamemode : GAMEMODE = GAMEMODE.PLAY ## For testing purposes this is PLAY

var player : Player
var enemies = []


func _ready() -> void:
	_init()
	print("Ready has run")

func _init() -> void:
	if current_gamemode == GAMEMODE.PLAY:
		for i in get_tree().current_scene.get_children():
			if i.is_in_group("Enemy"):
				enemies.append(i)
		print(enemies.size() , " enemies")

func _process(delta: float) -> void:
	pass

func gamemode_transition(new_gamemode : GAMEMODE) -> void:
	if current_gamemode == new_gamemode:
		return
	
	if new_gamemode == GAMEMODE.MENU:
		#get_tree().change_scene_to_file(" menu scene here ")
		pass 
	elif new_gamemode == GAMEMODE.PLAY:
		get_tree().change_scene_to_file("res://Scenes/Projectiles/Projectile_Green.tscn")
		pass
	
	current_gamemode = new_gamemode
	_init()
	
