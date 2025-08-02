extends StaticBody2D

enum FacingDirection {Forward, Back, Right, Left}
@onready var MyAnimatedSprite = $AnimatedSprite2D
@export var MyFacingDirection = FacingDirection.Forward
@onready var MyDelayTimer = $AnimatedSprite2D/FireDelayTimer
var ProjectileStartVelocity:Vector2
var isDead = false

var MyProjectile = "res://Scenes/Projectiles/bullet_green.tscn"

func _ready() -> void:
	PlayIdleAnimation()
	SetStartVelocity()
	pass

func _process(delta: float) -> void:
	pass

func SetStartVelocity() -> void:
	if MyFacingDirection == FacingDirection.Forward:
		ProjectileStartVelocity = Vector2(0,1)
	if MyFacingDirection == FacingDirection.Back:
		ProjectileStartVelocity = Vector2(0,-1)
	if MyFacingDirection == FacingDirection.Right:
		ProjectileStartVelocity = Vector2(1,0)
	if MyFacingDirection == FacingDirection.Left:
		ProjectileStartVelocity = Vector2(-1,0)
	pass

func PlayIdleAnimation() -> void:
	if MyFacingDirection == FacingDirection.Forward:
		MyAnimatedSprite.play("IdleForward")
	if MyFacingDirection == FacingDirection.Back:
		MyAnimatedSprite.play("IdleBack")
	if MyFacingDirection == FacingDirection.Right:
		MyAnimatedSprite.play("IdleRight")
	if MyFacingDirection == FacingDirection.Left:
		MyAnimatedSprite.play("IdleLeft")
	pass

func _on_fire_delay_timer_timeout() -> void:
	FireProjectile()
	pass # Replace with function body.

func Die() -> void:
	if MyFacingDirection == FacingDirection.Forward:
		MyAnimatedSprite.play("DeathForward")
	if MyFacingDirection == FacingDirection.Back:
		MyAnimatedSprite.play("DeathBack")
	if MyFacingDirection == FacingDirection.Right:
		MyAnimatedSprite.play("DeathRight")
	if MyFacingDirection == FacingDirection.Left:
		MyAnimatedSprite.play("DeathLeft")
	isDead = true
	pass

func TakeDamage() -> void:
	Die()
	pass

func FireProjectile() -> void:
	if !isDead:
		#MyProjectile.instantiate(ProjectileStartVelocity)
		pass
	pass


func _on_animated_sprite_2d_animation_finished() -> void:
	if MyAnimatedSprite.animation == "DeathForward":
		queue_free()
	if MyAnimatedSprite.animation == "DeathBack":
		queue_free()
	if MyAnimatedSprite.animation == "DeathRight":
		queue_free()
	if MyAnimatedSprite.animation == "DeathLeft":
		queue_free()
	pass # Replace with function body.
