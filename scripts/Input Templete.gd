extends Node

var is2_5D:bool = false
var is2D:bool = false 
var isFirst_preson:bool = false
var playerDead = false
var menu ={inventory =true,skill = false,quest = false}
var aim
var is_running:bool
var HUD 
var joystick

signal movement
signal menus_handle
signal playerInfo
signal cameraMove
signal aim
signal jump
signal attack 
signal dash
signal skill
signal switch
signal reload
func _ready():
	if get_tree().get_nodes_in_group("player").size()!=0:
		HUD = preload("res://scene/HUD manage.tscn").instance()
		add_child(HUD)
		joystick = HUD.joystick
		HUD.connect("input",self,"phone_input")
	self.pause_mode = Node.PAUSE_MODE_PROCESS
	pass 

func _input(event):
	if !get_tree().paused:
		if asigned_os() =="pc":
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
			if event is InputEventMouseMotion:
				emit_signal("cameraMove",event.relative)
		if asigned_os() == "phone":
			if event.index == joystick.onGoing_drag:
				if event is InputEventScreenDrag:
					emit_signal("cameraMove",event.relative)
		if asigned_os() =="console":
			pass
	else:
		pass
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func asigned_os():
	if OS.get_name() == "Android" or OS.get_name() == "iOS" :
		return "phone"
	if OS.get_name() == "UWP" :
		return "console"
	if OS.get_name() == "X11" or OS.get_name() == "Windows" or OS.get_name() == "OSX" :
		return "pc"

func phone_input(value):
	match value.action:
		"switch":
			emit_signal("switch",value)
		"attack":
			print("attack")
			emit_signal("attack",value.arg)
		"jump":
			emit_signal("jump")
		"dash":
			emit_signal("dash",value.arg)
		"skill":
			emit_signal("skill",value.arg)
	pass
func get_playerInfo(info):
	playerDead = info.playerDead
	if info.Type==2:
		is2_5D = true
	elif info.Type ==1:
		is2D = true
	elif info.Type ==3:
		isFirst_preson = true
	elif info.Type ==4:
		is2D =false
		isFirst_preson =false
	pass

func _process(delta):
	if asigned_os() =="pc":
		if Input.is_action_just_pressed("switch"):
			emit_signal("switch")
		if Input.is_action_just_pressed("reload"):
			emit_signal("reload")
		if  Input.is_action_just_pressed("ui_cancel"):
			if get_tree().paused:
				get_tree().paused= false
			else:
				get_tree().paused = true
		if Input.is_action_just_pressed("inventory"):
			if menu.inventory:
				menu.inventory = false
			else:
				menu.inventory = true
			emit_signal("menus_handle",menu)
		if Input.is_action_just_pressed("quest"):
			if menu.quest:
				menu.quest = false
			else:
				menu.quest= true
			emit_signal("menus_handle",menu)
		if Input.is_action_just_pressed("skill"):
			if menu.skill:
				menu.skill = false
			else:
				menu.skill = true
			emit_signal("menus_handle",menu)
		if Input.is_action_pressed("attack"):
			emit_signal("attack")
		if !is2D and !playerDead:
			if isFirst_preson:
				#implement first person
				pass
			else:
				
				var current_aim = Input.is_action_pressed("aim")
				if (aim != current_aim):
					aim = current_aim
					if (aim):
						emit_signal("aim",aim,delta)
					else:
						emit_signal("aim",aim,delta)
				if Input.is_action_pressed("run"):
					emit_signal("shot")
				if Input.is_action_pressed("ui_up"):
					emit_signal("movement",Vector2(0,1))
				if Input.is_action_pressed("ui_down"):
					emit_signal("movement",Vector2(0,-1))
				if Input.is_action_pressed("ui_right"):
					emit_signal("movement",Vector2(1,0))
				if Input.is_action_pressed("ui_left"):
					emit_signal("movement",Vector2(-1,0))
				if Input.is_action_pressed("ui_select"):
					emit_signal("jump")
		elif is2D and !playerDead:
			#implement 2D 
			pass
		elif is2_5D and !playerDead:
			if Input.is_action_pressed("ui_right"):
				emit_signal("movement",Vector2(1,0))
			if Input.is_action_pressed("ui_left"):
				emit_signal("movement",Vector2(-1,0))
			if Input.is_action_pressed("ui_select"):
				emit_signal("jump")
			#implement 2.5D
			pass
		else:
			return
	elif asigned_os() == "concole":
		pass
