extends KinematicBody2D

export (int) var speed = 100
export (NodePath) var patrol_path
export (int) var lives = 3

signal hit

var patrol_points
var patrol_index = 0
var velocity

func _ready():
	if patrol_path:
		patrol_points = get_node(patrol_path).curve.get_baked_points()

func _physics_process(delta):
	if !patrol_path:
		return
	var target = patrol_points[patrol_index]
	if position.distance_to(target) < 10:
		patrol_index = wrapi(patrol_index + 1, 0, patrol_points.size())
		target = patrol_points[patrol_index]
	velocity = (target - position).normalized() * speed
	velocity = move_and_slide(velocity)

func die():
	print("defeat")
	set_physics_process(false)

func win():
	print("victory")
	set_physics_process(false)

func _on_Objective_body_entered(body: Node) -> void:
	if (body.is_in_group("victims")):
		win()

func _on_Hitbox_body_entered(body: Node) -> void:
	if (body.is_in_group("hostile")):
		lives -= 1
		emit_signal("hit")
	if (lives == 0):
		die()
