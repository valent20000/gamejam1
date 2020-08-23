extends KinematicBody2D

export (int) var speed = 100
export (NodePath) var patrol_path
export (int) var lives = 1
export (int, 0, 200) var push = 100

signal death
signal hit

var patrol_points
var patrol_index = 0
var velocity

func _ready():
	if patrol_path:
		patrol_points = get_node(patrol_path).curve.get_baked_points()

func realistic_move():
	velocity = move_and_slide(velocity, Vector2.ZERO,false, 4, PI/4, false)
	for index in get_slide_count():
		var collision = get_slide_collision(index)
		if collision.collider.is_in_group("bodies"):
			collision.collider.apply_central_impulse(-collision.normal * push)

func _physics_process(delta):
	if !patrol_path:
		return
	var target = patrol_points[patrol_index]
	if position.distance_to(target) < 10:
		patrol_index = wrapi(patrol_index + 1, 0, patrol_points.size())
		target = patrol_points[patrol_index]
	velocity = (target - position).normalized() * speed
	realistic_move()

func die():
	print("defeat")
	queue_free()
	set_physics_process(false)

func win():
	print("victory")
	queue_free()
	set_physics_process(false)

func _on_Objective_body_entered(body: Node) -> void:
	if (body.is_in_group("victims")):
		win()
 
func body_entered(body):
	if (body.is_in_group("hostile")):
		lives -= 1
		emit_signal("hit")
		check_death()

func check_death():
	if (lives <= 0):
		die()
