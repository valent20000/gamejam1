extends Node2D

func _on_shoot(bullet, rotation, position):
	pass # Replace with function body.


func _on_Player_shoot(bullet, direction, location):
	var b = bullet.instance()
	add_child(b)
	b.rotation = direction
	b.position = location
	b.velocity = b.velocity.rotated(direction)
