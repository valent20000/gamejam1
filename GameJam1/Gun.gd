extends Node2D

var mousePos
var size

export var Bullet = preload("res://Bullet.tscn")

signal shoot(bullet, rotation, position)

func _ready():
	size = $GunSprite.frames.get_frame("default", 0).get_size()

func _physics_process(delta):
	mousePos = get_local_mouse_position()
	rotation += mousePos.angle() + PI/2

func _on_fire():
	emit_signal("shoot", Bullet, rotation, position + position.normalized()*size.y)
