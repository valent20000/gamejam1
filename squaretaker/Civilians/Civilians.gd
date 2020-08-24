extends KinematicBody2D

export (int) var speed = 100
export (NodePath) var patrol_path
export (int) var lives = 1

signal death

var patrol_points
var patrol_index = 0
var velocity

func _ready():
	print(patrol_path)
	if patrol_path:
		patrol_points = get_node(patrol_path).curve.get_baked_points()

func orient(pos):
	look_at(pos)
	rotate(PI/2)

func _physics_process(delta):
	if !patrol_path:
		return
	var target = patrol_points[patrol_index]
	if position.distance_to(target) < 10:
		patrol_index = wrapi(patrol_index + 1, 0, patrol_points.size())
		target = patrol_points[patrol_index]
	orient(target)
	velocity = (target - position).normalized() * speed
	velocity = move_and_slide(velocity)

func die():
	emit_signal("death")
	queue_free()

func body_entered(body):
	if (body.is_in_group("hostile")):
		lives -= 1
	check_death()
	
func check_death():
	if (lives <= 0):
		die()
