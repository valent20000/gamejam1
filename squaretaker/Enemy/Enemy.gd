extends KinematicBody2D

export (int) var lives = 1

var alert = false
var target

signal fire
signal shoot(bullet, rotation, position)

signal death

#Someone is coming here !
func _on_FOV_body_entered(body):
	#if body is the victim
	target = body
	alert = true

#Lost sight
func _on_FOV_body_exited(body):
	alert = false
	
func _process(delta):
	if alert:
		emit_signal("fire")
	else:
		pass
		
func _physics_process(delta):
	if alert:
			$Gun.orient(target.position)
			look_at(target.position)
			rotate(PI/2)


func _on_Hitbox_body_entered(body: Node) -> void:
	if (body.is_in_group("hostile")):
		lives -= 1
	if (lives == 0):
		die()

func die():
	emit_signal("death")
	queue_free()


func _on_Gun_shoot(bullet, direction, location):
	emit_signal("shoot", bullet, direction, location)
