extends RigidBody2D

export var lives = 2

var dead = false

signal death

func die():
	emit_signal("death")
	dead = true
	$Body.disabled = true
	visible = false
	disable()

func disable():
	set_process(false)
	set_physics_process(false)

func body_entered(body):
	if (body.is_in_group("hostile")):
		lives -= 1
		$SFXHit.play_random()
	if (lives <= 0):
		die()
		

func _on_SFXHit_finished():
	if dead:
		queue_free()
