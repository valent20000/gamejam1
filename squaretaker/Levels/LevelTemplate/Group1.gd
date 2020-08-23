extends Node2D

func _draw():
	if $Engineer1:
		if $Landmine1:
			draw_line($Engineer1.position, $Landmine1.position, Color(1,0,0))

func _process(delta):
	update()
