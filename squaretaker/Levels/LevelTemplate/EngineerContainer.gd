extends Node2D

export (PackedScene) var Explosion

func _on_Landmine1_explosion(pos, radius):
	var explo = Explosion.instance()
	print(pos)
	explo.set_global_position(pos)
	explo.set_radius(radius)
	add_child(explo)
	
	
