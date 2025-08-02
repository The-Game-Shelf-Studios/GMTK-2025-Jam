class_name Player extends CharacterBody2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var player_state_machine: PlayerStateMachine = $PlayerStateMachine
@onready var my_wonderline: Wonderline = $Wonderline
@onready var dodge_cooldown_timer: Timer = $DodgeCooldown

var direction : Vector2
var cardinal_direction = Vector2.DOWN

@export var max_health : int = 30
var current_health : int

var dodge_on_cooldown := false

func _ready() -> void:
	initialize_player()

func _process(delta: float) -> void:
	direction = Input.get_vector("Move_Left","Move_Right","Move_Up","Move_Down")
	if Input.is_action_pressed("Draw"):
		my_wonderline.drawing = true
	if Input.is_action_just_released("Draw"):
		for enemy in my_wonderline.check_for_capture():
			if enemy is Enemy:
				enemy._take_damage(my_wonderline.wonderline_strength)
			pass
		my_wonderline.drawing = false
		my_wonderline.total_purge()

func _physics_process(delta: float) -> void:
	move_and_slide()

func initialize_player() -> void:
	GameManager.player = self
	current_health = max_health
	# Initialize State Machine
	player_state_machine.initialize(self)

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

func _on_hurtbox_recieved_damage(damage: int) -> void:
	current_health -= damage
	print("Player took ", damage, " damage.")


func _on_dodge_cooldown_timeout() -> void:
	dodge_on_cooldown = false
