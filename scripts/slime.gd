extends Node2D

@onready var rightRayCast: RayCast2D = $RayCastRight
@onready var leftRayCast: RayCast2D = $RayCastLeft
@onready var animatedSprite: AnimatedSprite2D = $AnimatedSprite2D

@export var isUpsideDown: bool = false

const SPEED: int = 60
var movementDirection = 1

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if rightRayCast.is_colliding():
		if isUpsideDown:
			movementDirection = 1
		else:
			movementDirection = -1
		animatedSprite.flip_h = true
	if leftRayCast.is_colliding():
		if isUpsideDown:
			movementDirection = -1
		else:
			movementDirection = 1
		animatedSprite.flip_h = false
	
	position.x += movementDirection * SPEED * delta
