extends KinematicBody2D

export (int) var lives = 2
export (int) var speed = 160
export (int) var damage = 1

var alert = false
var moving = false
var target
var current_path
var fighting_fit = true

var dead = false

#used for signals
var id
signal victim_spotted(id, startposition, endposition)

func _ready():
	randomize()
	id = rand_range(1, 100000)

signal death

#Someone is coming here !
func _on_FOV_body_entered(body):
	if (body.is_in_group("good")):
		# if he is already shooting the victim, no point in changing
		if (alert && target != null && target.is_in_group("victims")):
			return
		target = body
		alert = true
		if (target.is_in_group("victims")):
			emit_signal("victim_spotted", id, position, target.position)
	
func _process(delta):
	if (target == null):
		return
	if moving:
		emit_signal("victim_spotted", id, position, target.position)
		var move_distance = speed * delta
		move_along_path(move_distance)
	if (fighting_fit && $Hurtbox.get_overlapping_bodies().has(target)):
		swing(target)

func _on_Hitbox_body_entered(body: Node) -> void:
	if (body.is_in_group("hostile")):
		lives -= 1
		$SFXHit.play_random()
	if (lives <= 0):
		die()

func die():
	dead = true
	emit_signal("death")
	disable()
	queue_free()

func disable():
	set_process(false)
	set_physics_process(false)

func _on_LevelTemplate_path_to_victim(id, path) -> void:
	if (id == self.id):
		moving = true
		current_path = path
		current_path.remove(0)

func move_along_path(distance):
	if (current_path == null):
		return
	var start_point = position
	#If problem go in line
	if (current_path.size() == 0):
		current_path.append(target.position)
	for i in range(current_path.size()):
		var distance_to_next = start_point.distance_to(current_path[0])
		if distance <= distance_to_next && distance_to_next >= 10:
			position = start_point.linear_interpolate(current_path[0], distance / distance_to_next)
			break
		elif distance_to_next <= 10:
			position = current_path[0]
#			moving = false
			break
		distance -= distance_to_next
		start_point = current_path[0]
		current_path.remove(0)

signal swing

func _on_Hurtbox_body_entered(body: Node) -> void:
	swing(body)

func swing(body):
	if (body.is_in_group("good") && fighting_fit):
		body.lives -= damage
		emit_signal("swing")
		moving = false
		fighting_fit = false
		$HitCooldown.start()

func _on_HitCooldown_timeout() -> void:
	moving = true
	fighting_fit = true

func _on_SFXHit_finished():
	if dead:
		queue_free()

func body_entered(body):
	if (body.is_in_group("hostile")):
		lives -= 1
		$SFXHit.play_random()
	if (lives <= 0):
		die()
