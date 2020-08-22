extends Node2D

var mousePos
var size = get_node("Sprite").texture.get_size()

export var Bullet = preload("res://Bullet.tscn")

signal shoot

func _physics_process(delta):
	mousePos = get_local_mouse_position()
	rotation += mousePos.angle() + PI/2


func _on_Player_fire():
	emit_signal("shoot", Bullet, rotation, position + position.normalized()*size.y)
	
