extends Area2D

export var radius = 10

var disabled = false

signal explosion(position, radius)

func _on_Landmine_body_entered(body):
	if body.is_in_group("alive") and not disabled:
		emit_signal("explosion", get_global_position(), radius)
		die()
	
func _on_owner_death():
	$AnimatedSprite.modulate = Color(0.3,0.3,0.3)
	disabled = true
	
func die():
	queue_free()
