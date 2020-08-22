extends Node

export (PackedScene) var MobileObstacle

var screensize = Vector2(1366, 768)

func _ready():
	for _i in range(5):
		var mo = MobileObstacle.instance()
		mo.position = Vector2(rand_range(0, screensize.x), rand_range(0, screensize.y))
		$MobileObstacleContainer.add_child(mo)
