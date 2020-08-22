extends KinematicBody2D

var velocity = Vector2(0,1)
export var speed = 20

func _physics_process(delta):
	var collision_info = move_and_collide(velocity * speed * delta)
	if collision_info:
		velocity = velocity.bounce(collision_info.normal)
