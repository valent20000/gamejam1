extends KinematicBody2D

export (int) var speed = 200
export (int, 0, 200) var push = 100

export var lives = 3

signal fire
signal shoot(bullet, rotation, position)
signal reload

signal hit

var velocity = Vector2()

func get_input():
	velocity = Vector2()
	if Input.is_action_pressed('ui_right'):
		velocity.x += 1
	if Input.is_action_pressed('ui_left'):
		velocity.x -= 1
	if Input.is_action_pressed('ui_down'):
		velocity.y += 1
	if Input.is_action_pressed('ui_up'):
		velocity.y -= 1
	velocity = velocity.normalized() * speed
	
func get_fire():
	if Input.is_action_pressed("click"):
		emit_signal("fire")

func realistic_move():
	velocity = move_and_slide(velocity,Vector2.ZERO,false, 4, PI/4, false)
	for index in get_slide_count():
		var collision = get_slide_collision(index)
		if collision.collider.is_in_group("bodies"):
			collision.collider.apply_central_impulse(-collision.normal * push)
				
func _physics_process(delta):
	get_input()
	$Gun.orient(get_global_mouse_position())
	get_fire()
	realistic_move()
	look_at(get_global_mouse_position())
	rotate(PI/2)

func body_entered(body):
	if (body.is_in_group("hostile")):
		lives -= 1
	if (lives <= 0):
		die()

func _on_Gun_shoot(bullet, direction, location):
	emit_signal("shoot", bullet, direction, location)

func _on_Gun_reload():
	emit_signal("reload")
	

func die():
	print("Player is DEAD")
	queue_free()
