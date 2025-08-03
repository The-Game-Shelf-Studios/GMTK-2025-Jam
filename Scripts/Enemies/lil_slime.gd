extends Enemy

@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var attack_delay_timer : Timer  = $AttackDelay
@onready var attack_cooldown_timer: Timer = $AttackCooldown
@onready var MyProjectile = preload("res://Scenes/Projectiles/Projectile_Green.tscn")

var ProjectileStartVelocity : Vector2

var anim_direction : Vector2 = Vector2.DOWN
@export var projectiles_per_volley : int = 3
var times_fired : int = 0
@export_range(0.000,1.000) var fire_delay : float = .1
@export_range(0.000,100.0) var fire_cooldown : float = 1

@export var line_bonus : int = 10

var on_cooldown := false

func _ready() -> void:
	update_animation("Idle")
	attack_delay_timer.wait_time = fire_delay

func _process(delta: float) -> void:
	if !is_dead && change_player_direction():
		update_animation("Idle")

func change_player_direction() -> bool:
	var player_dir : Vector2
	var new_dir : Vector2
	if GameManager.player:
		player_dir = GameManager.player.global_position - global_position
		ProjectileStartVelocity = player_dir.normalized()
	
	if player_dir == Vector2.ZERO:
		return false
	
	if ProjectileStartVelocity.x <= 0:
		new_dir = Vector2.LEFT if ProjectileStartVelocity.y > 0 else Vector2.RIGHT
	if ProjectileStartVelocity.y <= 0:
		new_dir = Vector2.UP if ProjectileStartVelocity.x < 0 else Vector2.DOWN
	
	if new_dir == anim_direction:
		return false
	
	anim_direction = new_dir.normalized()
	return true


func update_animation(anim_name : String , dying : bool = false) -> void:
	animated_sprite_2d.play(anim_name + "_" + set_anim_direction())
	if dying:
		animated_sprite_2d.animation_finished.connect( death )

func set_anim_direction() -> String:
	if anim_direction == Vector2.DOWN:
		return "Down"
	elif anim_direction == Vector2.UP:
		return "Up"
	elif anim_direction == Vector2.LEFT:
		return "Left"
	else:
		return "Right" 

func death() -> void:
	animated_sprite_2d.animation_finished.disconnect( death )
	remove_from_game_manager()
	GameManager.player.increase_line_size(10)
	queue_free()

func FireProjectile() -> void:
	if times_fired >= projectiles_per_volley:
		on_cooldown = true
		attack_cooldown_timer.start()
	
	if !is_dead && !on_cooldown:
		var projectile := MyProjectile.instantiate() as Projectile_Green
		projectile.direction = ProjectileStartVelocity
		add_child(projectile)
		attack_delay_timer.start()
		times_fired += 1
	pass

func _on_attack_delay_timeout() -> void:
	FireProjectile()

func _on_attack_cooldown_timeout() -> void:
	times_fired = 0
	on_cooldown = false
	FireProjectile()

func _on_begin_death() -> void:
	update_animation("Death" , true)
