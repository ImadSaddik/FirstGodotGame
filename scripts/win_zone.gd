extends Area2D

signal player_won

@export var levelWonSoundEffect: AudioStreamPlayer2D
@onready var timer: Timer = $Timer

func _on_body_entered(_body: Node2D) -> void:
	timer.start()


func _on_timer_timeout() -> void:
	emit_signal("player_won")
	levelWonSoundEffect.play()
