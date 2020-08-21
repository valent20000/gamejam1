extends Node2D

var mousePos

func _ready():
	pass

func _physics_process(delta):
	mousePos = get_local_mouse_position()
	rotation += mousePos.angle() + PI/2
