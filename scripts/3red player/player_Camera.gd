extends Spatial

var ray
export var distance = 4.0
export var axi_senstive = 0.01

var InnerGimbal
var RotationLimit = 45
var Rotation = Vector2()
var first = false
var rot = 0.0
signal not_aiming
var target 
var targets=[]
var way_point
var aim
var body
var cam 
var cam_col
export (float)var fov
func _ready():
	cam = get_node("InnerGimbal/Spatial/Camera")
	cam.translation.z =-distance
	cam.fov = fov
	Input_Templete.connect("cameraMove",self,"cam_movement")
	Input_Templete.connect("aim",self,"aiming")
	Input_Templete.connect("attack",self,"check_for_target")
	body = get_tree().get_nodes_in_group("player")[0].get_node("body")
	if body.get_parent().playerType ==3:
		first = true
		set_camera_type(3)
	else:
		first = false
		set_camera_type(4)
#	if first:
#		target = get_parent().get_global_transform().origin
#		pos = get_global_transform().origin
#		offset =  pos - target
#		offset = offset.normalized() * distance 
#		pos = target + offset
#		look_at_from_position(pos,target,Vector3(0,1,0))
	

	
	InnerGimbal = get_node("InnerGimbal")
	pass

#func _process(delta):
#	if aim:
#		return
#	else:
#		check_for_target()
#		check_camera()
func set_camera_type(type):
	match type:
		2:
			$AnimationPlayer.play("aim")
		3:
			$AnimationPlayer.play("first_person")
		4:
			$AnimationPlayer.play("third")
	
	pass
func aiming(value,TIME = 0.0):
	if !first:
		if value :
			aim =true
			set_camera_type(2)
		else:
			aim =false
			set_camera_type(4)
		body.aim = value
	else:
		body.aim = false

func cam_movement(move:Vector2) -> void:
	Rotation = move
	if !first:
		
		if !aim:
			rotate_y(deg2rad(-Rotation.x)*axi_senstive)
		else:
			emit_signal("not_aiming",deg2rad(-Rotation.x)*axi_senstive)
	else:
		emit_signal("not_aiming",deg2rad(-Rotation.x)*axi_senstive)
	
	InnerGimbal.rotate_x(deg2rad(Rotation.y)*axi_senstive)
	InnerGimbal.rotation_degrees.x = clamp(InnerGimbal.rotation_degrees.x, -RotationLimit, RotationLimit)
	Rotation = Vector2()
	
#func target_compass():
#	var compass = get_node("body/compass")
#	if target != null and(get_parent().contact or get_parent().is_on_floor()):
#		compass.visible = true
#		compass.look_at(target.get_global_tranform(),Vector3(0,1,0))
#		compass.rotation.x = 0
#		compass.rotation.z = 0
#	else:
#
#		if way_point != null and (get_parent().contact or get_parent().is_on_floor()):
#			compass.visible = true
#			compass.look_at(way_point.get_translation(),Vector3(0,1,0))
#			compass.rotation.x = 0
#			compass.rotation.z = 0
#		else:
#			compass.visible = false
#func check_camera():
#	if get_node("InnerGimbal/Camera/check_target").is_colliding():
#		if get_node("InnerGimbal/Camera/check_target").get_collider() != get_parent():
#			get_node("check_camera").cast_to =cam.get_global_transform().origin
#			get_node("check_camera").cast_to.y -=1
#	pass
#	if get_node("check_camera").is_colliding():
#		if get_node("check_camera").get_collider() != cam_col:
#			var dis = get_node("check_camera").get_global_transform().origin.distance_to(get_node("check_camera").get_collision_point())
#			set_camera_distance(Vector3(0,0,dis))
#	else:
#		set_camera_distance(Vector3(0,0,-distance))
#
func set_camera_distance(value:Vector3):
	cam.translation = value
##
#func check_for_target():
#	if target != null:
#		cam.look_at(target.get_global_transform().origin)
#	if targets.size() !=0:
#		var dis_of_object=[]
#		for i in targets:
#			dis_of_object.append(i.distance_to(body))
#			pass
#		var temp = dis_of_object
#		dis_of_object.sort()
#		return targets.find(temp.find(dis_of_object[0]))
		
	
#	pass
#
#
#func _on_range_body_entered(object):
#	if object.is_in_group("Target") and object != get_parent() :
#		if targets.size() == 0:
#			targets.append(object)
#		else:
#			if object in targets:
#				pass
#			else:
#				targets.append(object)
#	pass # Replace with function body.
#
#
#func _on_range_body_exited(object):
#	if object in targets:
#		targets.remove(targets.find(object))
#	pass # Replace with function body.
