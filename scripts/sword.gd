extends Node2D

@export var swordAnimationPlayer: AnimationPlayer
@export var animatedSprite: Sprite2D


func swing_sword() -> void:
	swordAnimationPlayer.play("swing_sword")


func set_x_position(value: float) -> void:
	self.position.x = value
	if value < 0:
		animatedSprite.flip_h = true
	else:
		animatedSprite.flip_h = false
