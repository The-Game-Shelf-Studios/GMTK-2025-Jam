extends State

@onready var idle : State = $"../Idle"
@onready var move : State = $"../Move"
@onready var dodge_timer: Timer = $DodgeTimer


@export var dodge_speed: float = 400
var dodge_finished : bool = false

# What happens when player enters this state?
func Enter() -> void:
	dodge_finished = false
	dodge_timer.start()
	pass
	
# What happens when player exit's this state?
func Exit() -> void:
	player.dodge_on_cooldown = true
	player.dodge_cooldown_timer.start()
	pass # Replace with function body.
	
# What happens during _process update in this State? 
func Process(_delta : float) -> State:
	if dodge_finished:
		if player.direction == Vector2.ZERO:
			return idle
		else:
			return move
	return null
	
# What happens during _physics_process in this state?
func Physics(_delta : float) -> State:
	if !dodge_finished:
		player.move(dodge_speed, "Move")
	return null
	
# What happens with Input Events in this State?
func HandleInput(_event : InputEvent) -> State:
	# Replace with function body.
	return null


func _on_dodge_timer_timeout() -> void:
	dodge_finished = true
