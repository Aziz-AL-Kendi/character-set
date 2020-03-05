tool
extends Node
class_name State_Machine

var state = null
var body
var character
var anim
var states = []
var state_machine 
var animationTree
var anim_speed

func _ready():
	body = get_parent()
	character = body.get_parent()
	
	
	animationTree = get_parent().get_node("AnimationTree")
	state_machine = animationTree.get("parameters/playback")
	
	pass

func _process(delta):
	if state != null:
		var transition = _get_transition(delta)
		if transition != null:
			_set_state(transition)
		else:
			play_state_machine_state(transition)

func set_init_anim(anime_id,wordIn_It=false):
	state = states[search(anime_id,wordIn_It)]

# warning-ignore:unused_argument
func _get_transition(delta):
	return

func _set_state(new_state):
	state = new_state
	
	if new_state != null:
		_enter_state(new_state)

func _enter_state(new_state):
	for i in states:
		if i == new_state:
			play_state_machine_state(i)
	pass

func play_state_machine_state(new_state):
	if new_state != null:
		state_machine.travel(new_state)
	pass


func _add_state(state_name):
	states.append(state_name)

func search(key,in_it= false):
	var a =-1
	for i in states:
		a+=1
		if key == i and !in_it:
			return a
		elif key in i and in_it:
			return a

func _get_configuration_warning():
	var warrning = ""
	if state_machine == null:
		warrning = "Add an AnimeationTree node and set Tree Root to Ainmation Node State Machine"+"\n"+"Note: Dont rename the AnimationTree node\nAnd dont add states because there built in now"
	return warrning
func change_speed(value):
	anim.set_speed(value)
	
