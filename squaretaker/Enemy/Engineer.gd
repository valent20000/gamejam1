extends RigidBody2D

export var lives = 2

signal death

func die():
	emit_signal("death")
	queue_free()

func body_entered(body):
	if (body.is_in_group("hostile")):
		lives -= 1
	if (lives <= 0):
		die()
