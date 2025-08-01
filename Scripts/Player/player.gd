class_name Player extends CharacterBody2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var player_state_machine: PlayerStateMachine = $PlayerStateMachine
@onready var wonderline: Wonderline = $Wonderline

var direction : Vector2
var cardinal_direction = Vector2.DOWN

func _ready() -> void:
	# Initialize State Machine
	player_state_machine.initialize(self)

func _process(delta: float) -> void:
	direction = Input.get_vector("Move_Left","Move_Right","Move_Up","Move_Down")
	if Input.is_action_pressed("Draw"):
		wonderline.drawing = true
	if Input.is_action_just_released("Draw"):
		wonderline.check_for_capture()
		wonderline.drawing = false
		wonderline.total_purge()

func _physics_process(delta: float) -> void:
	move_and_slide()

func move(speed : float, state_name : String) -> void:
	velocity = direction * speed
	if set_direction():
		update_animation(state_name)
	
func update_animation(state_name : String) -> void:
	animated_sprite_2d.play( state_name + "_" + animation_direction())

func set_direction() -> bool:
	var new_dir : Vector2 = cardinal_direction
	if velocity == Vector2.ZERO:
		return false
		
	if velocity.y == 0:
		new_dir = Vector2.LEFT if velocity.x < 0 else Vector2.RIGHT
	if velocity.x == 0: 
		new_dir = Vector2.UP if velocity.y < 0 else Vector2.DOWN
		
	if new_dir == cardinal_direction:
		return false
		
	cardinal_direction = new_dir
	animated_sprite_2d.scale.x = -1 if cardinal_direction == Vector2.LEFT else 1
	return true

func animation_direction() -> String:
	if cardinal_direction == Vector2.DOWN:
		return "Down"
	elif cardinal_direction == Vector2.UP:
		return "Up"
	else:
		return "Side" 
