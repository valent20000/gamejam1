extends Node

export (PackedScene) var MobileObstacle

export (PackedScene) var next_scene

var levelsize

export (int) var enemy_number

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
		
	$Foreground/HUD.life = $Player.lives
	$Foreground/HUD.victim_life = $Victim.lives
	$Foreground/HUD.number = enemy_number
	$Foreground/HUD.initialize()

signal path_to_victim(id, path)

func _on_victim_spotted(id, startposition, endposition) -> void:
	var path = $Navigation2D.get_simple_path(startposition, endposition)
	emit_signal("path_to_victim", id, path)


func _on_Victim_death():
	$Music.stop()
	
func _on_Victim_reload():
	get_tree().reload_current_scene()

func _on_Victim_win():
	get_tree().load_scene(next_scene)
