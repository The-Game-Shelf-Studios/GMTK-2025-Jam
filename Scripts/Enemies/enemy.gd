class_name Enemy extends StaticBody2D

@export_category("Enemy Base Stats")
@export var health : int  = 1

var is_dead := false
signal begin_death

func _take_damage(damage : int) ->void:
	health -= damage
	if health <= 0:
		is_dead = true
		begin_death.emit()

func remove_from_game_manager() -> void:
	if GameManager.enemies.has(self):
		GameManager.enemies.erase(self)
