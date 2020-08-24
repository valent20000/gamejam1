extends KinematicBody2D

var velocity = Vector2(0,1)
export var speed = 20
export var life = 3

export var rotate_speed = 5

export (int, 0, 5000) var push = 100

func realistic_move(delta):
	var collision_info = move_and_collide(velocity * speed * delta, false)
	if collision_info:
		if collision_info.collider.is_in_group("bodies"):
			collision_info.collider.apply_central_impulse(-collision_info.normal*push)
		if collision_info.collider.is_in_group("alive"):
			collision_info.collider.body_entered(self)
		if collision_info.collider.is_in_group("hostile"):
			collision_info.collider.queue_free()
			
		velocity = velocity.bounce(collision_info.normal)
		return true
	return false
	
func _physics_process(delta):
	var event = realistic_move(delta)
	rotate(rotate_speed*delta)
	if event:
		life-=1
		if life <= 0:
			queue_free()
