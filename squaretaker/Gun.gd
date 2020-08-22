extends Node2D

var mousePos
var size

export var Bullet = preload("res://Bullet.tscn")
export var cooldown = 5
export var ammo = 6
export var time_between_shoot = 0.5
var ammo_left = ammo
var no_ammo = false
var can_shoot = true

signal shoot(bullet, rotation, position)

func _ready():
	size = $GunSprite.frames.get_frame("default", 0).get_size()

func _on_fire():
	if can_shoot:
		$TimeBetweenShoot.start()
		can_shoot = false
		if ammo_left:
			var vec = 1.1*Vector2(0, size.y).rotated(get_global_rotation())
			emit_signal("shoot", Bullet, get_global_rotation(), get_global_position() - vec)
			ammo_left-=1
			if ammo_left <= 0:
				no_ammo = true
				$Reload.start()

func orient(position):
	look_at(position)
	rotate(PI/2)

func _on_TimeBetweenShoot_timeout():
	can_shoot = true

func _on_Reload_timeout():
	no_ammo = false
	ammo_left = ammo
