extends Node

enum GAMEMODE { PLAY , PAUSE , MENU , GAMEOVER }
var current_gamemode : GAMEMODE = GAMEMODE.PLAY ## For testing purposes this is PLAY

var player : Player
var enemies = []

#TODO: Scene Transitions

func _ready() -> void:
	if current_gamemode == GAMEMODE.PLAY:
		for i in get_tree().current_scene.get_children():
			if i.is_in_group("Enemy"):
				enemies.append(i)
		print(enemies.size() , " enemies")

func _process(delta: float) -> void:
	pass
