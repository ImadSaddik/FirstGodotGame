extends Node2D

signal player_died

@export var rightRayCast: RayCast2D
@export var leftRayCast: RayCast2D
@export var animatedSprite: AnimatedSprite2D
@export var animationPlayer: AnimationPlayer
@export var isUpsideDown: bool = false

const SPEED: int = 60
var movementDirection = 1

func _process(delta: float) -> void:
	if rightRayCast.is_colliding():
		movementDirection = 1 if isUpsideDown else -1
		animatedSprite.flip_h = true
	if leftRayCast.is_colliding():
		movementDirection = -1 if isUpsideDown else 1
		animatedSprite.flip_h = false

	position.x += movementDirection * SPEED * delta


func _on_player_died() -> void:
	emit_signal("player_died")
	
	
func play_explosion_animation() -> void:
	animationPlayer.play("explode")
