tool
extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var joystick 
var button_list
signal input
# Called when the node enters the scene tree for the first time.
func _ready():
	button_list =$"HBoxContainer/control/HBoxContainer/buttons".get_children()
	joystick = $"HBoxContainer/control/HBoxContainer/joystick container/Control/Sprite".get_node("joystick")
	get_tree().get_nodes_in_group("player")[0].connect("statues",self,"set_statues")
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	pass
func set_statues(statues):
	get_node("HBoxContainer/control/HBoxContainer/statues/status/health_bar/ProgressBar").max_value = int(statues.max_health)
	$HBoxContainer/control/HBoxContainer/statues/status/health_bar/ProgressBar.value = int(statues.health)
	$HBoxContainer/control/HBoxContainer/statues/status/MP_bar/ProgressBar.max_value = statues.max_mana
	$HBoxContainer/control/HBoxContainer/statues/status/MP_bar/ProgressBar.value = statues.mana
	$HBoxContainer/control/HBoxContainer/statues/status/health_bar/NinePatchRect/Label2.text = "%s / %s" % [int(statues.health),int(statues.max_health)]
	$HBoxContainer/control/HBoxContainer/statues/status/MP_bar/NinePatchRect/Label2.text = "%s / %s" % [int(statues.mana),int(statues.max_mana)]
	pass
