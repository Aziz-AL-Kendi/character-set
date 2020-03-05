extends Node

enum type{twoD=1,twoPoint5D=2,firstPerson=3,thirdPreson=4}
export var statues ={health =50,max_health = 100,mana = 200,max_mana =200,xp =0,max_xp = 5,level = 1,attack = 20,deffance=20,critecle = 12,speed=20,accelerat = 15,jump_hight = 10,camera_distence = 20}

export(type) var playerType 
var info

signal statues
signal level_up 


func _ready():
	info = {Type = playerType,dead = false}
	statues.health = statues.max_health
	statues.mana = statues.max_mana
	Input_Templete.connect("menus_handle",self,"subMenu_handler")
	pass

func _process(delta):
	
	emit_signal("statues",statues)
	Input_Templete.emit_signal("playerInfo",info)
	if statues.health<= 0:
		player_dead()
	else:
		statues.health += 0.5 *delta

	if statues.health >= statues.max_health:
		statues.health = statues.max_health

	if statues.mana <= 0:
		statues.mana = 0
	else:
		statues.mana += 1.5*delta

	if statues.mana >= statues.max_mana:
		statues.mana = statues.max_mana

	if statues.xp >= statues.max_xp:
		level_up()


func player_dead():
	info.dead= true
	statues.xp -= statues.xp * 0.05


func got_hit(lv = 1,damage = 10):
	statues.health -= pow(damage,lv)/1.5

func level_up():
	statues.max_health += statues.ax_health * 0.10
	statues.max_mana += statues.max_mana * 0.05
	statues.max_xp = xp_required(statues.level+1)
	statues.health = statues.max_health
	statues.mana = statues.max_mana
	statues.xp = 0
	statues.level += 1
	emit_signal("level_up",statues.level)

func xp_required(level):
	return round( pow(level , 1.8) * level * 4)

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "":
		$ui/levels/level.text = statues.level
	pass # Replace with function body.

func get_player():
	return self

func update_status():
	$body.speed = statues.speed
	$body.running_speed = statues.running_speed
	$body.jump_hight = statues.jump_hight
	$body/Spatial/InnerGimbal/Camera.distance = statues.camera_distence

func subMenu_handler(menu):
	#implement menus
	if menu.inventory:
		pass
	else:
		pass
	if menu.skill:
		pass
	else:
		pass
	if menu.quest:
		pass
	else:
		pass
