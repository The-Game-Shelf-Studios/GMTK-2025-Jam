class_name State extends Node

## To make individual States: 
## 1- Duplicate this script
## 2- Extend State instead of Node and change class_name
## 3- Remove Player Variables as they are static

## TODO: Add variables for Enemies to use States as well

# Player variables
static var player : Player
static var player_state_machine : PlayerStateMachine

func _ready():
	pass # Replace with function body.

# What haooens when state machine initializes
func init() -> void:
	pass # Replace with function body.

# What happens when player enters this state?
func Enter() -> void:
	pass # Replace with function body.
	
# What happens when player exit's this state?
func Exit() -> void:
	pass # Replace with function body.
	
# What happens during _process update in this State? 
func Process(_delta : float) -> State:
	# Replace with function body.
	return null
	
# What happens during _physics_process in this state?
func Physics(_delta : float) -> State:
	# Replace with function body.
	return null
	
# What happens with Input Events in this State?
func HandleInput(_event : InputEvent) -> State:
	# Replace with function body.
	return null
