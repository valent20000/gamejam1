extends Node2D

func _on_shoot(bullet, direction, location):
	var b = bullet.instance()
	add_child(b)
	b.rotation = direction
	b.position = to_local(location)
	b.velocity = -b.speed*b.velocity.rotated(direction)
