extends Node2D

@export var animationPlayer: AnimationPlayer


func play_sword_cooldown_animation() -> void:
	animationPlayer.play("progress_bar_to_zero")
