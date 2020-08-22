extends Node

export (PackedScene) var MobileObstacle
export (PackedScene) var Enemy

var levelsize

func _ready():
	randomize()
	levelsize = $Background.rect_size
	$Player/Camera2D.limit_left = 0
	$Player/Camera2D.limit_right = levelsize.x
	$Player/Camera2D.limit_top = 0
	$Player/Camera2D.limit_bottom = levelsize.y
	for _i in range(5):
		var mo = MobileObstacle.instance()
		mo.position = Vector2(rand_range(0, levelsize.x), rand_range(0, levelsize.y))
		$MobileObstacleContainer.add_child(mo)
	for _i in range(2):
		var e = Enemy.instance()
		e.position = Vector2(rand_range(100, levelsize.x - 100), rand_range(100, levelsize.y - 100))
		$EnemyContainer.add_child(e)
		e.connect("shoot", get_node("BulletSystem"), "_on_shoot")

	$Foreground/HUD.life = 42
	$Foreground/HUD.ammo = $Player/Gun.ammo
	$Foreground/HUD.victim_life = $Victim.lives
	$Foreground/HUD.number = 3
	$Foreground/HUD.initialize()
