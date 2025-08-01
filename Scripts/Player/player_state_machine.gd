class_name PlayerStateMachine extends Node

var states : Array[ State ]
var previous_state : State
var current_state : State

var initialized : bool = false ## Will determine if this needs to be initialized / Always starts false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	process_mode = Node.PROCESS_MODE_DISABLED ## Process functions are turned off until the state machine is intialized
	pass

# Initializes player state machine
func initialize( _player : Player ) -> void:
	print( "========= Player Initialization Begin =========" )
	states = [] ## Set states array to empty
	
	# Adds all children that are states to the states array
	for c in get_children():
		if c is State:
			states.append(c)
	
	if states.size() == 0:
		return
	print( str(states.size()) + " player states found" )
	
	# Set up refs
	states[0].player = _player
	states[0].player_state_machine = self
	
	# Initialize each state
	for state in states:
		state.init()
	print("All States Initialized")
	
	# Set first state and turn on process functions
	change_state( states[0] )
	process_mode = Node.PROCESS_MODE_INHERIT ## Inherits mode from parent in case player's process functions are off
	initialized = true
	print( "======== Player Initialization Finished ========" )


# Update Functions keep checking for a change in state #
func _process(delta: float) -> void:
	change_state(current_state.Process( delta ))
	pass

func _physics_process(delta: float) -> void:
	change_state(current_state.Physics( delta ))
	pass

func _unhandled_input(event: InputEvent) -> void:
	change_state(current_state.HandleInput( event ))
	pass


# Called when changing states
func change_state(new_state : State) -> void:
	# Check if null or same as current state
	if new_state == null || new_state == current_state:
		return
	
	# Calls current state's Exit function if it exists
	if current_state:
		current_state.Exit()
	
	# Finish setup of new and previous state
	previous_state = current_state
	current_state = new_state
	current_state.Enter()
