extends KinematicBody2D

var alert = false
var target

signal fire(target)

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
		emit_signal("fire", target)
	else:
		pass
