extends Area2D

@warning_ignore("unused_signal")
signal invert_gravity

func _on_body_entered(_body: Node2D) -> void:
	emit_signal("invert_gravity")
