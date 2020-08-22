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

signal path_to_victim(id, path)

func _on_Enemy_victim_spotted(id, startposition, endposition) -> void:
	var path = $Navigation2D.get_simple_path(startposition, endposition)
	emit_signal("path_to_victim", id, path)
