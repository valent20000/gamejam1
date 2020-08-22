extends KinematicBody2D

var velocity = Vector2(0,1)
export var speed = 20
export var life = 3

func _physics_process(delta):
	var collision_info = move_and_collide(velocity * speed * delta)
	if collision_info:
		velocity = velocity.bounce(collision_info.normal)
		life-=1
		if life < 0:
			queue_free()
