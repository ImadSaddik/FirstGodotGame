extends Node2D

@export var swordAnimationPlayer: AnimationPlayer


func swing_sword() -> void:
	swordAnimationPlayer.play("swing_sword")
