extends Area2D

var velocity
@export var speed = 5

func _ready() -> void:
	
	pass
	

func _process(delta: float) -> void:
	position += velocity
	pass

func _init(StartingDirection: Vector2) -> void:
	velocity = StartingDirection * speed
	pass
	
	
	
