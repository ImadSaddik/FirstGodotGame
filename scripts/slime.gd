extends Node2D

signal player_died

@export var rightRayCast: RayCast2D
@export var leftRayCast: RayCast2D
@export var animatedSprite: AnimatedSprite2D
@export var animationPlayer: AnimationPlayer
@export var isUpsideDown: bool = false
@export var detectionRadius: float = 100.0
@export var slimeBallScene: PackedScene
@export var shootBallTimer: Timer

@onready var player: CharacterBody2D = %Player

const SLIME_SPEED: int = 60
const MAX_PROJECTILE_HEIGHT: float = 30.0
const GRAVITY: float = 980.0
const PROJECTILE_SHOT_ANGLE: float = 45.0

var movementDirection = 1
var canShoot: bool = true

func _process(delta: float) -> void:
	move_slime(delta)
	shoot_ball()


func move_slime(delta: float) -> void:
	if rightRayCast.is_colliding():
		movementDirection = 1 if isUpsideDown else -1
		animatedSprite.flip_h = true
	if leftRayCast.is_colliding():
		movementDirection = -1 if isUpsideDown else 1
		animatedSprite.flip_h = false
	
	#position.x += movementDirection * SLIME_SPEED * delta


func shoot_ball() -> void:
	if not player or not canShoot:
		return
		
	if player.isDead:
		return
	
	var distanceToPlayer = position.distance_to(player.position)
	if distanceToPlayer <= detectionRadius:
		shoot_at_player()
	
	
func shoot_at_player() -> void:
	if not slimeBallScene:
		return
		
	canShoot = false
	var slimeBall = spawn_slime_ball()
	
	var angleInRadians = deg_to_rad(PROJECTILE_SHOT_ANGLE)
	var distanceToPlayer = position.distance_to(player.position)
	var projectileSpeed = calculate_projectile_speed(angleInRadians, distanceToPlayer)
	
	var initialVelocityX = projectileSpeed * cos(angleInRadians)
	var initialVelocityY = projectileSpeed * sin(angleInRadians)
	
	var target_pos = player.position
	if target_pos.x < position.x:
		initialVelocityX = -initialVelocityX
	
	slimeBall.linear_velocity = Vector2(initialVelocityX, -initialVelocityY)
	
	
func spawn_slime_ball() -> RigidBody2D:
	var slimeBall = slimeBallScene.instantiate()
	get_parent().add_child(slimeBall)
	slimeBall.position = position
	slimeBall.connect("player_died", _on_player_died)
	return slimeBall
	

func calculate_projectile_speed(angle: float, distanceToPlayer: float) -> float:
	var numerator = distanceToPlayer * GRAVITY
	var denominator = sin(2*angle)
	var projectileSpeed = sqrt(float(numerator) / denominator)
	return projectileSpeed


func _on_player_died() -> void:
	emit_signal("player_died")
	
	
func play_explosion_animation() -> void:
	animationPlayer.play("explode")


func stop_shooting_balls() -> void:
	canShoot = false
	shootBallTimer.stop()


func _on_shoot_ball_timer_timeout() -> void:
	canShoot = true
