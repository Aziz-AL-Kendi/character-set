tool
extends Spatial

class_name weapon
export var status = {damage =100,critical_chanse=20,critical_multe =2.3,damage_effect=20,fire=0,electricity=0 ,ice=0,poison=0,speed =10}
export var held_right:bool
export var held_left:bool
var used =false setget set_used,get_used
#var mods = {s1,s2,s3}

func action():
	if !used:
		return
	pass
func set_used(value):
	used =value
	if used:
		Input_Templete.connect("attack",self,"action")
	else:
		Input_Templete.disconnect("attack",self,"action")
func get_used():
	return used
