extends Area2D

var first = true

func _ready():
	$Explosion.set_emitting(true) 
	$Sound.play()

func set_radius(r):
	$Body.shape.set_radius(r)
	$Explosion.set_visibility_rect(Rect2(-r,-r,r,r))


func _on_DissipationTime_timeout():
	queue_free()
	
func _physics_process(delta):
	if first:
		first = false
	else:
		$Body.disabled = true

func _on_Area2D_body_entered(body):
	if body.is_in_group("alive"):
		body.body_entered(self)
