extends KinematicBody

export var speed :float = 5
export var jump_hight:float = 12
export (NodePath) var object 
var rotating_object
const gravity = -9.8
const max_fall_speed = 3
var y_velo = 0
var facing_right = false
var dir = Vector3()
var velocity = Vector3()
func _ready():
	rotating_object= get_node(object)
	Input_Templete.connect("movement",self,"move")
	Input_Templete.connect("jump",self,"jumping")
	pass # Replace with function body.
func move(value):
	dir.x = value.x
	if dir.x >0:
		facing_right= true
	if dir.x <0:
		facing_right = false
func jumping():
	velocity.y =jump_hight
func _physics_process(delta):
	
	if dir.x !=0 or dir.z !=0:
		var angle = atan2( dir.x,0)
		rotating_object.rotation.y = angle

	dir = dir * speed * delta
	dir =dir.normalized()
	
	velocity.x  = dir.x
	velocity.y += gravity *delta
	velocity = move_and_slide(velocity,Vector3(0,1,0))
	dir = Vector3(0,0,0)
