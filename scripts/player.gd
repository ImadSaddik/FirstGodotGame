extends CharacterBody2D

@onready var animatedSprite: AnimatedSprite2D = $AnimatedSprite2D
@export var jumpSoundEffect: AudioStreamPlayer2D
@export var deathSoundEffect: AudioStreamPlayer2D

const SPEED = 130.0
const JUMP_VELOCITY = -300.0

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
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
	deathSoundEffect.play()
