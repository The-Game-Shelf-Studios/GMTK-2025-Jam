class_name Hurtbox extends Area2D

signal recieved_damage (damage : int)

func _on_area_entered(hitbox : Hitbox) -> void:
	if hitbox != null:
		recieved_damage.emit(hitbox.damage)
