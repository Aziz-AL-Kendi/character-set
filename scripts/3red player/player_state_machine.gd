extends State_Machine

var fall_delay = 100
var airborne_time = 100.0
var min_airborne_time = 0.1
var on_air = false
var jump 
var aim =false
var weapon_type
func _ready():
#	used only when building you own states
	_add_state("idle")
	_add_state("movement")
	_add_state("jump")
	_add_state("fall")
#	_add_state("slide")
#	_add_state("hurt")
	_add_state("dead")
#	set_init_anim(0)
#-------------------------------------------------
#	used when having "built_in" active
	set_init_anim("idle",true)
		

	pass


func _get_transition(delta):
	fall_delay +=delta
	if states != null:
		if character.playerType ==3:
			animationTree["parameters/idle/mele/blend_amount"]=0
		elif character.playerType ==4:
			if aim :
				animationTree["parameters/idle/mele/blend_amount"]=1
				animationTree["parameters/idle/rifle/blend_amount"]=1
				animationTree["parameters/movement/mele/blend_amount"]=1
				pass
			else:
				animationTree["parameters/movement/mele/blend_amount"]=0
				pass
		if !body.is_on_floor() or !body.contact:
			on_air = true
			if jump and body.Velocity.y > 0:
				jump =false
				return states[search("jump",true)]
			elif (body.Velocity.y <= 0 or !jump) and on_air:
				if fall_delay > 0.03:
					fall_delay = 0.0
					return states[search("fall",true)]
		elif body.Dirction.x != 0 or body.Dirction.z != 0:
			if aim:
				animationTree["parameters/movement/rifle_aim/blend_position"]=Vector2(body.Dirction.x,body.Dirction.z)
			if get_parent().running:
				animationTree["parameters/movement/normal/blend_position"]=1
			if !get_parent().running:
				animationTree["parameters/movement/normal/blend_position"]=0
			return states[search("movement",true)]
		elif character.statues.health <= 0:
			return states[search("dead",true)]
		else:
			on_air = false
			return states[search("idle",true)]
	

