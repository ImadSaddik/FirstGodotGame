extends CharacterBody2D

@onready var animatedSprite: AnimatedSprite2D = $AnimatedSprite2D
@export var jumpSoundEffect: AudioStreamPlayer2D
@export var deathSoundEffect: AudioStreamPlayer2D
@export var timer: Timer

const SPEED = 130.0
const JUMP_VELOCITY = -300.0
const CLIMB_SPEED = 100.0

var canMove: bool = true
var isOnLadder: bool = false
var canDoubleJump: bool = true

func _physics_process(delta: float) -> void:
	if not canMove:
		return

	# Add the gravity.
	if not is_on_floor() and not isOnLadder:
		velocity += get_gravity() * delta
		# Handle double jump
		if Input.is_action_just_pressed("jump") and canDoubleJump:
			canDoubleJump = false
			velocity.y = JUMP_VELOCITY
			jumpSoundEffect.play()
		
	# Handle ladder climbing
	if isOnLadder:
		var vertical_direction = Input.get_axis("move_up", "move_down")
		(vertical_direction)
		velocity.y = vertical_direction * CLIMB_SPEED
		animatedSprite.play("climb")

	# Handle jump
	if Input.is_action_just_pressed("jump") and is_on_floor():
		canDoubleJump = true
		velocity.y = JUMP_VELOCITY
		jumpSoundEffect.play()

	# Get the input direction, it can be either -1, 0, 1.
	var direction := Input.get_axis("move_left", "move_right")
	
	# Flip the sprite
	if direction < 0:
		animatedSprite.flip_h = true
	elif direction > 0:
		animatedSprite.flip_h = false
		
	# Play animations
	if is_on_floor():
		if direction == 0:
			animatedSprite.play("idle")
		else:
			animatedSprite.play("run")
	else:
		animatedSprite.play("jump")
	
	# Move the player
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	
	
func play_death_sound() -> void:
	timer.start()


func _on_timer_timeout() -> void:
	deathSoundEffect.play()
