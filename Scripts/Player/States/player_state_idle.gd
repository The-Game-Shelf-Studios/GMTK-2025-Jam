extends State

@onready var move : State = $"../Move"

# What happens when player enters this state?
func Enter() -> void:
	player.update_animation("Idle")
	
# What happens when player exit's this state?
func Exit() -> void:
	pass # Replace with function body.
	
# What happens during _process update in this State? 
func Process(_delta : float) -> State:
	# If Player inputs a direction change to move state
	if player.direction != Vector2.ZERO:
		return move
	else:
		player.velocity = Vector2.ZERO
	
	return null

# What happens during _physics_process in this state?
func Physics(_delta : float) -> State:
	# Replace with function body.
	return null
	
# What happens with Input Events in this State?
func HandleInput(_event : InputEvent) -> State:
	# Replace with function body.
	return null
