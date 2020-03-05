extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export (PackedScene) var melee_packed
export (PackedScene) var ranger_packed
var melee
var ranger
var in_use
export (NodePath) var right_hand
export (NodePath) var left_hand
var state_machine
var type =""
export var tag:bool
# Called when the node enters the scene tree for the first time.
func _ready():
	state_machine = get_parent().get_node("body/state_machine")
	Input_Templete.connect("switch",self,"switch")

	if tag:
		switch(0)
	pass # Replace with function body.

func _change(weapon):
	weapon.used = true
	if weapon.held_right :
		print(get_node(right_hand))
		if get_node(left_hand) != null:
			get_node(left_hand).get_children().clear()
		get_node(right_hand).add_child(weapon)
	elif weapon.held_left: 
		if get_node(right_hand) != null:
			get_node(right_hand).get_children().clear()
		get_node(left_hand).add_child(weapon)
	elif weapon.held_left and weapon.held_right:
		get_node(left_hand).add_child(weapon)
		get_node(right_hand).add_child(weapon)
	else:
		
		get_node(right_hand).get_children().clear()
		get_node(left_hand).get_children().clear()

func switch(value):
	if in_use == melee or melee == null:
		if ranger_packed != null:
			ranger= ranger_packed.instance()
		in_use =ranger
		_change(in_use)
	elif in_use == ranger or ranger == null:
		if melee_packed != null:
			melee= melee_packed.instance()
		in_use = melee
		_change(in_use)
