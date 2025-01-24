extends Area2D

@onready var gameManager: Node = %GameManager
@onready var animationPlayer: AnimationPlayer = $AnimationPlayer

func _on_body_entered(_body: Node2D) -> void:
	animationPlayer.play("pick_up")
	gameManager.add_point()
