tool
extends weapon

class_name ranger
enum bullet_type{raycast=1,physices = 0}
export (bullet_type) var type 
export(NodePath) var bulliet_emitter
export (PackedScene) var bullet 
export var multe_shot = false
export var ammo =30
export var magazine = 90
var raycast
var can_fire:bool
func _ready():
	Input_Templete.connect("reload",self,"reload")
	status["ammo_cap"] = ammo
	status["magazine_cap"] = magazine
	status["ammo"] =  status["ammo_cap"]
	status["magazine"] = status["magazine_cap"]
	raycast = get_node(bulliet_emitter)
	can_fire = true
func _process(delta):
	if status.ammo <=0:
		reload()
func action():
	pass
func shoot():
	if status.ammo > 0 and status.ammo !=0 :
		status.ammo-=1
		if type == 1:
			if raycast != null:
				if raycast.is_colliding():
					var ob = raycast.get_collider()
					if ob.is_in_group("Target"):
						damage(ob)
						pass
		else:
			if multe_shot:
				for i in rand_range(1.0,5.0):
					var new_bullet = bullet.instance()
					get_tree().get_root().add_child(new_bullet)
					new_bullet.global_transform = raycast.global_transform
					new_bullet.speed = status.speed
					new_bullet.damage = status.damage
				pass
			else:
				var new_bullet = bullet.instance()
				get_tree().get_root().add_child(new_bullet)
				new_bullet.global_transform = raycast.global_transform
				new_bullet.speed = status.speed
				new_bullet.damage = status.damage
				pass
			
		pass
func reload():
	if status.magazine <=0 or status.ammo ==ammo:
		return
	if status.ammo <=0:
		status.magazine -=ammo 
		print(status.magazine)
	else:
		status.magazine -= (ammo - status.ammo)
	status.ammo = ammo - status.ammo

	pass

func damage(object):
	if object.has_method("damage"):
		object.damage(status.damage)
	pass

func _get_configuration_warning():
	var warning =""
	if bulliet_emitter.is_empty():
		warning = "hello"
	return warning
	
