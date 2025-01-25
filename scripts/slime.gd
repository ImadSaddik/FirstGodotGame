extends Node2D

@warning_ignore("unused_signal")
signal player_died

@export var rightRayCast: RayCast2D
@export var leftRayCast: RayCast2D
@export var animatedSprite: AnimatedSprite2D
@export var animationPlayer: AnimationPlayer
@export var isUpsideDown: bool = false
@export var detectionRadius: float = 100.0
@export var slimeBallScene: PackedScene
@export var shootBallTimer: Timer
@export var explosionTimer: Timer
@export var slapSoundEffect: AudioStreamPlayer2D
@export var player: CharacterBody2D

enum SlimeType {NORMAL, FIRE, ICE}
@export_enum("Normal", "Fire", "Ice") var slime_type: int = SlimeType.NORMAL

const SLIME_SPEED: int = 60
const GRAVITY: float = 980.0
const PROJECTILE_SHOT_ANGLE: float = 45.0
const OFFSET_SLIME_BALL_FROM_GROUND: float = 10.0

var movementDirection = 1
var canShoot: bool = true


func _ready() -> void:
	play_idle_animation()


func _process(delta: float) -> void:
	move_slime(delta)
	shoot_ball()
	
	
func play_idle_animation() -> void:
	match slime_type:
		SlimeType.NORMAL:
			animatedSprite.play("idle")
		SlimeType.FIRE:
			animatedSprite.play("idle_fire")
		SlimeType.ICE:
			animatedSprite.play("idle_ice")


func move_slime(delta: float) -> void:
	if rightRayCast.is_colliding():
		movementDirection = 1 if isUpsideDown else -1
		animatedSprite.flip_h = true
	if leftRayCast.is_colliding():
		movementDirection = -1 if isUpsideDown else 1
		animatedSprite.flip_h = false
	
	position.x += movementDirection * SLIME_SPEED * delta


func shoot_ball() -> void:
	if not player or player.isDead or not canShoot:
		return
	
	var distanceToPlayer = position.distance_to(player.position)
	if distanceToPlayer <= detectionRadius:
		shoot_at_player()
	
	
func shoot_at_player() -> void:
	if not slimeBallScene:
		return
	
	canShoot = false
	var slimeBall = spawn_slime_ball()
	var velocity = calculate_projectile_velocity(player.position)
	slimeBall.linear_velocity = velocity


func calculate_projectile_velocity(targetPosition: Vector2) -> Vector2:
	var angleInRadians = deg_to_rad(PROJECTILE_SHOT_ANGLE)
	var horizontalDistance = abs(targetPosition.x - position.x)
	var projectileSpeed = calculate_projectile_speed(angleInRadians, horizontalDistance)

	var initialVelocityX = projectileSpeed * cos(angleInRadians)
	var timeToTarget = horizontalDistance / initialVelocityX
	
	# Calculate required vertical velocity considering height difference
	# Read this brilliant openstax section for more details: https://openstax.org/books/university-physics-volume-1/pages/4-3-projectile-motion
	# The formula used here is derived from the kinematic equation: y = y0 + v0y*t + 0.5*a*t^2
	# Solve for v0y, you get: v0y = (y - y0 + 0.5*a*t^2) / t
	var heightDifference = targetPosition.y - position.y
	var initialVelocityY = (-heightDifference + 0.5 * GRAVITY * timeToTarget * timeToTarget) / timeToTarget
	
	# If the player is on the left side of the slime, shoot the ball to the left
	if targetPosition.x < position.x:
		initialVelocityX = -initialVelocityX
	
	return Vector2(initialVelocityX, -initialVelocityY)


func calculate_projectile_speed(angle: float, distanceToPlayer: float) -> float:
	var numerator = distanceToPlayer * GRAVITY
	var denominator = sin(2*angle)
	var projectileSpeed = sqrt(float(numerator) / denominator)
	return projectileSpeed


func spawn_slime_ball() -> RigidBody2D:
	var slimeBall = slimeBallScene.instantiate()
	get_parent().add_child(slimeBall)
	slimeBall.position = position
	slimeBall.position.y -= OFFSET_SLIME_BALL_FROM_GROUND
	slimeBall.connect("player_died", _on_player_died)
	return slimeBall


func _on_player_died() -> void:
	emit_signal("player_died")
	
	
func play_explosion_animation() -> void:
	animationPlayer.play("explode")


func play_death_sound_effect() -> void:
	slapSoundEffect.play()


func stop_shooting_balls() -> void:
	canShoot = false
	shootBallTimer.stop()


func _on_shoot_ball_timer_timeout() -> void:
	canShoot = true


func remove_from_game() -> void:
	explosionTimer.start()


func _on_explosion_timer_timeout() -> void:
	queue_free()
