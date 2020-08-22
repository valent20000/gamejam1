extends TextureButton

var next_scene = preload("res://Levels/LevelTemplate/LevelTemplate.tscn")

func _on_Play_pressed():
	get_tree().change_scene_to(next_scene)
