extends State

@onready var idle : State = $"../Idle"
@onready var dodge: Node = $"../Dodge"

@export var move_speed : float = 100.0

# What happens when player enters this state?
func Enter() -> void:
	player.update_animation("Move")
	
# What happens when player exit's this state?
func Exit() -> void:
	pass # Replace with function body.
	
# What happens during _process update in this State? 
func Process(_delta : float) -> State:
	# Replace with function body.
	return null
	
# What happens during _physics_process in this state?
func Physics(_delta : float) -> State:
	# Set State to Idle if not moving
	if player.direction == Vector2.ZERO:
		return idle
	
	player.move(move_speed, "Move")
	return null
	
# What happens with Input Events in this State?
func HandleInput(_event : InputEvent) -> State:
	if _event.is_action_pressed("Dodge") && !player.dodge_on_cooldown:
		return dodge
	return null
