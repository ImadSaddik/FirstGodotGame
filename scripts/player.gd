extends CharacterBody2D

@export var playerAnimatedSprite: AnimatedSprite2D
@export var jumpSoundEffect: AudioStreamPlayer2D
@export var deathSoundEffect: AudioStreamPlayer2D
@export var sword: Node2D
@export var deathSoundTimer: Timer
@export var swordCooldownTimer: Timer
@export var shieldCooldownTimer: Timer
@export var swordCooldown: Node2D
@export var shield: Node2D
@export var playerCollisionShape: CollisionShape2D
@export var walkParticles: GPUParticles2D
@export var jumpParticles: GPUParticles2D

const SPEED: float = 130.0
const JUMP_VELOCITY: float = -300.0
const CLIMB_SPEED: float = 100.0
const SWORD_X_OFFSET_IN_PIXELS: float = 5.5
const SWORD_COOLDOWN_X_OFFSET_IN_PIXELS: float = 10
const MAX_JUMPS_ALLOWED = 2
const MAX_SHIELD_USAGE_ALLOWED = 1

var isDead: bool = false
var isOnPlatform: bool = false
var isLevelCompleted: bool = false
var isOnLadder: bool = false
var canDoubleJump: bool = true
var jumpsPerformed: int = 0
var platformCollisionShape: CollisionShape2D = null
var isGravityInverted: bool = false
var canHitWithSword: bool = true
var canUseShield: bool = true
var shieldIsUsed: bool = false
var shieldUsage: int = 0

func _physics_process(delta: float) -> void:
	if isDead or isLevelCompleted:
		return
	
	if is_on_floor() or is_on_ceiling():
		reset_double_jumps()
		handle_jump()
		
	if is_in_air():
		apply_gravity(delta)
		handle_double_jump()
	
	if isOnLadder:
		handle_ladder_climbing()
		
	handle_actions()
	move_and_slide()
	

func play_death_sound() -> void:
	deathSoundTimer.start()


func reset_double_jumps() -> void:
	canDoubleJump = true
	jumpsPerformed = 0


func handle_jump() -> void:
	if Input.is_action_just_pressed("jump"):
		jumpsPerformed += 1
		velocity.y = -JUMP_VELOCITY if isGravityInverted else JUMP_VELOCITY
		jumpSoundEffect.play()
		show_jump_particles()


func show_jump_particles():
	if jumpsPerformed < MAX_JUMPS_ALLOWED:
		jumpParticles.emitting = true
	else:
		var newParticles = jumpParticles.duplicate()
		add_child(newParticles)
		newParticles.global_position = global_position
		newParticles.emitting = true
		
		await get_tree().create_timer(newParticles.lifetime).timeout
		newParticles.queue_free()


func is_in_air() -> bool:
	if isGravityInverted:
		return not is_on_ceiling() and not isOnLadder
	else:
		return not is_on_floor() and not isOnLadder


func apply_gravity(delta: float) -> void:
	var gravity = -get_gravity() if isGravityInverted else get_gravity()
	velocity += gravity * delta


func handle_double_jump() -> void:
	if not canDoubleJump:
		return
	
	handle_jump()
	if jumpsPerformed >= MAX_JUMPS_ALLOWED:
		canDoubleJump = false


func handle_ladder_climbing() -> void:
	var vertical_direction = Input.get_axis("move_up", "move_down")
	velocity.y = vertical_direction * CLIMB_SPEED


func handle_actions() -> void:
	if Input.is_action_just_pressed("hit") and canHitWithSword:
		sword.swing_sword()
		canHitWithSword = false
		swordCooldownTimer.start()
		swordCooldown.play_sword_cooldown_animation()
	
	if Input.is_action_just_pressed("shield") and canUseShield and shieldUsage < MAX_SHIELD_USAGE_ALLOWED:
		shieldUsage += 1
		shieldIsUsed = true
		canUseShield = false
		shield.show_shield_with_cooldown()
	
	if Input.is_action_just_pressed("move_down") and isOnPlatform:
		platformCollisionShape.disabled = true
	
	# Get the input direction, it can be either -1, 0, 1.
	var direction := Input.get_axis("move_left", "move_right")
	flip_player_based_on_direction(direction)
	move_player_in_direction(direction)
	play_animations(direction)
	show_walk_particles(direction)


func flip_player_based_on_direction(direction: float) -> void:
	if direction < 0:
		playerAnimatedSprite.flip_h = true
		sword.set_x_position(-SWORD_X_OFFSET_IN_PIXELS)
		swordCooldown.position.x = SWORD_COOLDOWN_X_OFFSET_IN_PIXELS
	elif direction > 0:
		playerAnimatedSprite.flip_h = false
		sword.set_x_position(SWORD_X_OFFSET_IN_PIXELS)
		swordCooldown.position.x = -SWORD_COOLDOWN_X_OFFSET_IN_PIXELS


func move_player_in_direction(direction: float) -> void:
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)


func play_animations(direction: float) -> void:
	if is_on_floor() or is_on_ceiling():
		if direction == 0:
			playerAnimatedSprite.play("idle")
		else:
			playerAnimatedSprite.play("run")
	else:
		playerAnimatedSprite.play("jump")


func show_walk_particles(direction: float) -> void:
	if direction != 0 and not is_in_air():
		walkParticles.emitting = true
	else:
		walkParticles.emitting = false


func invert_gravity() -> void:
	isGravityInverted = true
	scale.y = -1 if isGravityInverted else 1


func _on_player_on_platform(collisionShape: CollisionShape2D) -> void:
	isOnPlatform = true
	platformCollisionShape = collisionShape


func _on_player_exited_platform(_collisionShape: CollisionShape2D) -> void:
	isOnPlatform = false
	platformCollisionShape = null


func _on_death_sound_timer_timeout() -> void:
	deathSoundEffect.play()


func _on_sword_cooldown_timer_timeout() -> void:
	canHitWithSword = true


func _on_shield_cooldown_timer_timeout() -> void:
	canUseShield = true


func _on_shield_power_end() -> void:
	shieldIsUsed = false
	shieldCooldownTimer.start()
