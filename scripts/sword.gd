extends Node2D

@export var swordAnimationPlayer: AnimationPlayer
@export var swordSoundEffect: AudioStreamPlayer2D
@export var animatedSprite: Sprite2D
@export var timer: Timer


func swing_sword() -> void:
	swordAnimationPlayer.play("swing_sword")
	swordSoundEffect.play()


func set_x_position(value: float) -> void:
	self.position.x = value
	if value < 0:
		animatedSprite.flip_h = true
	else:
		animatedSprite.flip_h = false


func _on_hit_box_area_entered(area: Area2D) -> void:
	if area.name == "HurtBox":
		var enemy = area.get_parent()
		enemy.play_explosion_animation()
		enemy.play_death_sound_effect()
		enemy.stop_shooting_balls()
