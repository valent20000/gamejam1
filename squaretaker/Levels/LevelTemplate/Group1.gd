extends Node2D

func _draw():
	if get_child_count() >= 2:
		draw_line($Engineer1.position, $Landmine1.position, Color(1,0,0))

func _process(delta):
	update()
