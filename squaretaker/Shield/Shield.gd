extends StaticBody2D

var available = true

func _ready():
	$CollisionShape2D.disabled = true
	$Sprite.hide()

func _process(delta):
	if Input.is_action_pressed("right_click") && available:
		$CollisionShape2D.disabled = false
		$Sprite.show()
		$ShieldDuration.start()
		$ShieldCooldown.start()
		available = false

func _on_ShieldDuration_timeout() -> void:
	$CollisionShape2D.disabled = true
	$Sprite.hide()
	available = false

func _on_ShieldCooldown_timeout() -> void:
	available = true
