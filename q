[1mdiff --git a/GameJam1/project.godot b/GameJam1/project.godot[m
[1mindex 7d4b208..a0720b1 100644[m
[1m--- a/GameJam1/project.godot[m
[1m+++ b/GameJam1/project.godot[m
[36m@@ -16,7 +16,7 @@[m [m_global_script_class_icons={[m
 [application][m
 [m
 config/name="GameJam1"[m
[31m-run/main_scene="res://Levels/LevelTemplate/LevelTemplate.tscn"[m
[32m+[m[32mrun/main_scene="res://TitleScreen.tscn"[m
 config/icon="res://icon.png"[m
 [m
 [display][m
[36m@@ -50,23 +50,12 @@[m [mui_down={[m
 , Object(InputEventJoypadButton,"resource_local_to_scene":false,"resource_name":"","device":0,"button_index":13,"pressure":0.0,"pressed":false,"script":null)[m
  ][m
 }[m
[31m-[m
[31m-[layer_names][m
[31m-[m
[31m-2d_physics/layer_1="player"[m
[31m-2d_physics/layer_2="enemy"[m
[31m-2d_physics/layer_3="civilian"[m
[31m-2d_physics/layer_4="client"[m
[31m-2d_physics/layer_5="obstacle"[m
[31m-2d_physics/layer_6="environment"[m
[31m-[m
[31m-[physics][m
[31m-[m
[31m-2d/default_gravity_vector=Vector2( 0, 0 )[m
[31m-2d/default_linear_damp=3.0[m
[31m-2d/default_angular_damp=3.0[m
[32m+[m[32mclick={[m
[32m+[m[32m"deadzone": 0.5,[m
[32m+[m[32m"events": [ Object(InputEventMouseButton,"resource_local_to_scene":false,"resource_name":"","device":0,"alt":false,"shift":false,"control":false,"meta":false,"command":false,"button_mask":0,"position":Vector2( 0, 0 ),"global_position":Vector2( 0, 0 ),"factor":1.0,"button_index":1,"pressed":false,"doubleclick":false,"script":null)[m
[32m+[m[32m ][m
[32m+[m[32m}[m
 [m
 [rendering][m
 [m
[31m-quality/2d/use_pixel_snap=true[m
 environment/default_environment="res://default_env.tres"[m
