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

var canMakeAction: bool = true
var isOnLadder: bool = false
var canDoubleJump: bool = true
var jumpsPerformed: int = 0

func _physics_process(delta: float) -> void:
	if not canMakeAction:
		return
		
	# Reset double jumps
	if is_on_floor():
		reset_double_jumps()

	# Add the gravity.
	if not is_on_floor() and not isOnLadder:
		velocity += get_gravity() * delta
		# Handle double jump
		if Input.is_action_just_pressed("jump") and canDoubleJump:
			jumpsPerformed += 1
			velocity.y = JUMP_VELOCITY
			jumpSoundEffect.play()
			
			if jumpsPerformed > 1:
				canDoubleJump = false
		
	# Handle ladder climbing
	if isOnLadder:
		var vertical_direction = Input.get_axis("move_up", "move_down")
		(vertical_direction)
		velocity.y = vertical_direction * CLIMB_SPEED
		playerAnimatedSprite.play("climb")

	# Handle jump
	if Input.is_action_just_pressed("jump") and is_on_floor():
		canDoubleJump = true
		jumpsPerformed += 1
		velocity.y = JUMP_VELOCITY
		jumpSoundEffect.play()
		
	# Hundle hit action
	if Input.is_action_just_pressed("hit"):
		sword.swing_sword()

	# Get the input direction, it can be either -1, 0, 1.
	var direction := Input.get_axis("move_left", "move_right")
	
	# Flip the sprite
	if direction < 0:
		playerAnimatedSprite.flip_h = true
		sword.set_x_position(-SWORD_X_OFFSET_IN_PIXELS)
	elif direction > 0:
		playerAnimatedSprite.flip_h = false
		sword.set_x_position(SWORD_X_OFFSET_IN_PIXELS)
	
	# Play animations
	if is_on_floor():
		if direction == 0:
			playerAnimatedSprite.play("idle")
		else:
			playerAnimatedSprite.play("run")
	else:
		playerAnimatedSprite.play("jump")
	
	# Move the player
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	move_and_slide()


func play_death_sound() -> void:
	timer.start()


func reset_double_jumps() -> void:
	canDoubleJump = true
	jumpsPerformed = 0


func _on_timer_timeout() -> void:
	deathSoundEffect.play()
