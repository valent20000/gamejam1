extends Node

export (PackedScene) var MobileObstacle

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
