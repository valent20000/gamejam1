extends Node2D

var mousePos
var size
var vec

export var Bullet = preload("res://Bullet.tscn")

signal shoot(bullet, rotation, position)

func _ready():
	size = $GunSprite.frames.get_frame("default", 0).get_size()
	vec = Vector2(0, size.y)

func _physics_process(delta):
	look_at(get_global_mouse_position())
	rotate(PI/2)

func _on_fire():
	var vec = Vector2(0, size.y).rotated(get_global_rotation())
	emit_signal("shoot", Bullet, get_global_rotation(), get_global_position() - vec)
