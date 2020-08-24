extends Node2D

var mousePos
var size

export (PackedScene) var Bullet
export var needs_reload = true


export var ammo = 6
var ammo_left = ammo
var no_ammo = false
var can_shoot = true

signal shoot(bullet, rotation, position)
signal reload

func _ready():
	size = $GunSprite.frames.get_frame("default", 0).get_size()

func _on_fire():
	if can_shoot and not no_ammo:
		$TimeBetweenShoot.start()
		can_shoot = false
		var vec = 1.4*Vector2(0, size.y).rotated(get_global_rotation())
		emit_signal("shoot", Bullet, get_global_rotation(), get_global_position() - vec)
		ammo_left-=1
		$SFXPlayer.play_random()
		if ammo_left <= 0 and needs_reload:
			no_ammo = true
			$Reload.start()

func orient(position):
	look_at(position)
	rotate(PI/2)

func _on_TimeBetweenShoot_timeout():
	can_shoot = true

func _on_Reload_timeout():
	emit_signal("reload")
	no_ammo = false
	ammo_left = ammo
