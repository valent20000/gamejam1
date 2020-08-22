extends KinematicBody2D

export (int) var speed = 200

signal fire
signal shoot(bullet, rotation, position)

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

func _physics_process(delta):
	get_input()
	get_fire()
	velocity = move_and_slide(velocity)
	look_at(get_global_mouse_position())
	rotate(PI/2)

func _on_Gun_shoot(bullet, direction, location):
	emit_signal("shoot", bullet, direction, location)
