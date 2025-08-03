class_name Player extends CharacterBody2D

@onready var animated_sprite_2d : AnimatedSprite2D = $AnimatedSprite2D
@onready var player_state_machine : PlayerStateMachine = $PlayerStateMachine
@onready var my_wonderline : Wonderline = $Wonderline
@onready var dodge_cooldown_timer : Timer = $DodgeCooldown
@onready var i_frame_timer : Timer = $Hurtbox/IFrameTimer

var direction : Vector2
var cardinal_direction = Vector2.DOWN

@export var max_health : int = 3
@export_range(0,1) var i_frame_length : float = .5
var current_health : int

var dodge_on_cooldown := false
var player_dead := false
var can_control := true
var invunlerable := false

var invulneralble_flicker := false

func _ready() -> void:
	initialize_player()

func _process(delta: float) -> void:
	if can_control:
		direction = Input.get_vector("Move_Left","Move_Right","Move_Up","Move_Down")
		if Input.is_action_pressed("Draw"):
			my_wonderline.drawing = true
		if Input.is_action_just_released("Draw"):
			for enemy in my_wonderline.check_for_capture():
				if enemy is Enemy:
					enemy._take_damage(my_wonderline.wonderline_strength)
			my_wonderline.drawing = false
			my_wonderline.total_purge()
	else:
		my_wonderline.drawing = false
		my_wonderline.total_purge()
	
	if invunlerable:
		i_frame_flicker()
	else:
		animated_sprite_2d.modulate = Color.WHITE

func _physics_process(delta: float) -> void:
	move_and_slide()

func initialize_player() -> void:
	GameManager.player = self
	current_health = max_health
	GameManager.heart_bar.update_health(max_health)
	# Initialize State Machine
	player_state_machine.initialize(self)
	i_frame_timer.wait_time = i_frame_length

func move(speed : float, state_name : String) -> void:
	if can_control:
		velocity = direction * speed
		if set_direction():
			update_animation(state_name)
	else:
		velocity = Vector2.ZERO
	
func update_animation(state_name : String, death : bool = false) -> void:
	animated_sprite_2d.play( state_name + "_" + animation_direction())
	if death:
		animated_sprite_2d.animation_finished.connect( player_death )

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

func i_frame_flicker() -> void:
	if !invulneralble_flicker:
		animated_sprite_2d.modulate = Color.RED
		invulneralble_flicker = true
	else:
		animated_sprite_2d.modulate = Color.WHITE
		invulneralble_flicker = false

func animation_direction() -> String:
	if cardinal_direction == Vector2.DOWN:
		return "Down"
	elif cardinal_direction == Vector2.UP:
		return "Up"
	else:
		return "Side" 

func player_death() -> void:
	player_dead = true

func _on_hurtbox_recieved_damage(damage: int) -> void:
	if !invunlerable:
		current_health -= damage
		GameManager.heart_bar.update_health(current_health)
		print("Player took ", damage, " damage.")
		
		if current_health <= 0 && !player_dead:
			can_control = false
			update_animation("Death", true)
		
		invunlerable = true
		i_frame_timer.start()

func _on_dodge_cooldown_timeout() -> void:
	dodge_on_cooldown = false
	
func increase_line_size(val : int) -> void:
	my_wonderline.max_points += val

func _on_i_frame_timer_timeout() -> void:
	invunlerable = false
