extends CharacterBody2D

@export var playerAnimatedSprite: AnimatedSprite2D
@export var jumpSoundEffect: AudioStreamPlayer2D
@export var deathSoundEffect: AudioStreamPlayer2D
@export var sword: Node2D
@export var timer: Timer

const SPEED: float = 130.0
const JUMP_VELOCITY: float = -300.0
const CLIMB_SPEED: float = 100.0
const SWORD_X_OFFSET_IN_PIXELS: float = 5.5

var isDead: bool = false
var isOnPlatform: bool = false
var isLevelCompleted: bool = false
var isOnLadder: bool = false
var canDoubleJump: bool = true
var jumpsPerformed: int = 0

func _physics_process(delta: float) -> void:
	if isDead or isLevelCompleted:
		return
	
	if is_on_floor():
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
	timer.start()


func reset_double_jumps() -> void:
	canDoubleJump = true
	jumpsPerformed = 0


func handle_jump() -> void:
	if Input.is_action_just_pressed("jump"):
		jumpsPerformed += 1
		velocity.y = JUMP_VELOCITY
		jumpSoundEffect.play()


func is_in_air() -> bool:
	return not is_on_floor() and not isOnLadder


func apply_gravity(delta: float) -> void:
	velocity += get_gravity() * delta


func handle_double_jump() -> void:
	if not canDoubleJump:
		return
	
	handle_jump()
	if jumpsPerformed > 1:
		canDoubleJump = false


func handle_ladder_climbing() -> void:
	var vertical_direction = Input.get_axis("move_up", "move_down")
	velocity.y = vertical_direction * CLIMB_SPEED
	playerAnimatedSprite.play("climb")


func handle_actions() -> void:
	if Input.is_action_just_pressed("hit"):
		sword.swing_sword()
	
	# Get the input direction, it can be either -1, 0, 1.
	var direction := Input.get_axis("move_left", "move_right")
	flip_player_based_on_direction(direction)
	move_player_in_direction(direction)
	play_animations(direction)


func flip_player_based_on_direction(direction: float) -> void:
	if direction < 0:
		playerAnimatedSprite.flip_h = true
		sword.set_x_position(-SWORD_X_OFFSET_IN_PIXELS)
	elif direction > 0:
		playerAnimatedSprite.flip_h = false
		sword.set_x_position(SWORD_X_OFFSET_IN_PIXELS)


func move_player_in_direction(direction: float) -> void:
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)


func play_animations(direction: float) -> void:
	if is_on_floor():
		if direction == 0:
			playerAnimatedSprite.play("idle")
		else:
			playerAnimatedSprite.play("run")
	else:
		playerAnimatedSprite.play("jump")


func _on_timer_timeout() -> void:
	deathSoundEffect.play()


func _on_player_on_platform() -> void:
	isOnPlatform = true


func _on_player_exited_platform() -> void:
	isOnPlatform = false
