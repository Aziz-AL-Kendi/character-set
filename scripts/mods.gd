extends Node

class_name mods
var status
var object
var set :bool =false
func _init(target):
	object=target
	
func _ready():
	
	
	pass


func set_mod():
	if set:
		object.status += status
	else:
		return

func set_status():
	
	pass
