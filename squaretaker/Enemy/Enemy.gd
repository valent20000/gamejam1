extends KinematicBody2D

export (int) var lives = 2
export (int) var speed = 160

var fire_allowed = false
var alert = false
var moving = false
var target
var current_path

var dead = false

#used for signals
var id
signal victim_spotted(id, startposition, endposition)

func _ready():
	randomize()
	id = rand_range(1, 100000)
	print(id)

signal fire
signal shoot(bullet, rotation, position)

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
	if alert and fire_allowed:
		emit_signal("fire")
	if moving:
		emit_signal("victim_spotted", id, position, target.position)
		var move_distance = speed * delta
		move_along_path(move_distance)
		
func _physics_process(delta):
	if (target == null):
		return
	if alert:
			$Gun.orient(target.position)
			look_at(target.position)
			rotate(PI/2)

func body_entered(body):
	if (body.is_in_group("hostile")):
		lives -= 1
		$SFXHit.play_random()
	if (lives <= 0):
		die()
		
func die():
	emit_signal("death")
	dead = true
	$CollisionShape2D.disabled = true
	visible = false

func _on_LevelTemplate_path_to_victim(id, path) -> void:
	if (id == self.id):
		moving = true
		current_path = path
		current_path.remove(0)

func move_along_path(distance):
	if (current_path == null):
		return
	var start_point = position
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

func _on_ShootingRange_body_exited(body: Node) -> void:
	if (body.is_in_group("good")):
		moving = true
		emit_signal("victim_spotted", id, position, body.position)
		fire_allowed = false
		
func _on_ShootingRange_body_entered(body: Node) -> void:
	if (body.is_in_group("good")):
		moving = false
		$Lag.start()

func _on_Gun_shoot(bullet, direction, location):
	emit_signal("shoot", bullet, direction, location)


func _on_Lag_timeout():
	fire_allowed = true


func _on_SFXHit_finished():
	if dead:
		queue_free()
