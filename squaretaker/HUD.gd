extends MarginContainer

var life = 0
var victim_life = 0
var number = 0

var current_life = 0
var current_victim_life = 0
var current_number = 0

onready var life_label = $HBoxContainer/Life/MarginContainer/Label
onready var victim_label = $HBoxContainer/VictimLife/MarginContainer3/Label
onready var number_label = $HBoxContainer/RemainingKillers/MarginContainer4/Label

func set_life():
	life_label.text = str(current_life) + "/" + str(life)

func set_victim_life():
	victim_label.text = str(current_victim_life) + "/" + str(victim_life)

func set_number():
	number_label.text = str(current_number) + "/" + str(number)


func initialize():
	current_life = life
	current_victim_life = victim_life
	current_number = number
	set_life()
	set_victim_life()
	set_number()
	
func _on_Player_hit():
	current_life-=1
	set_life()
	
func _on_Victim_hit():
	current_victim_life-=1
	set_victim_life()

func _on_Enemy_death():
	current_number-=1
	set_number()


func _on_Brute_death() -> void:
	pass # Replace with function body.
