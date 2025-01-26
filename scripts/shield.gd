extends Node2D

signal shield_power_end

@export var animationPlayer: AnimationPlayer
@export var shieldDurationTimer: Timer
@export var shieldIcon: TextureRect


func show_shield_with_cooldown() -> void:
	animationPlayer.play("show_shield_with_cooldown")
	shieldDurationTimer.start()


func _on_area_entered(area: Area2D) -> void:
	var slimeBall = area.get_parent()
	slimeBall.explode_slime_ball()


func _on_shield_duration_timer_timeout() -> void:
	shieldIcon.visible = false
	emit_signal("shield_power_end")
