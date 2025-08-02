class_name Projectile_Green extends RigidBody2D

var direction : Vector2
@export var speed = 50


func _physics_process(delta: float) -> void:
	linear_velocity = direction * speed
	pass

func _on_hitbox_area_entered(area: Area2D) -> void:
	print("Hit ", area.name)
	queue_free()
