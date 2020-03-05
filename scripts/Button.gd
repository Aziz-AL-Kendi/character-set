extends Button
class_name custom_button

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var value = {action = "",arg=[]}
# Called when the node enters the scene tree for the first time.
func _ready():
	connect("pressed",self,"action")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func action():
	value = custom_action()
	Input_Templete.phone_input(value)
	pass
func custom_action():
	
	pass
