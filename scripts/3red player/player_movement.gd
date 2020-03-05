extends KinematicBody
#charater move values

var speed = 10
var Dirction = Vector3()
var Gravity = -9.8
var Velocity 
var jump_hight = 10
var angle
var acel = 15
var slopeMax_angle = 75
var running = false
var running_timer  = 0.0
var raycast
var contact = false
var on_air = false
var cam
var slope_angle
export (NodePath) var object
export (NodePath) var camera_path = null

var camera
var aim = false
var running_speed
var ROTATION_INTERPOLATE_SPEED = 10

func _ready():
	speed = get_parent().statues.speed
	acel = get_parent().statues.accelerat
	running_speed =speed * 2
	Velocity = Vector3(0,0,0)
	raycast = get_node("RayCast")
	cam =get_node(camera_path)
	Input_Templete.connect("movement",self,"input_link")
	Input_Templete.connect("jump",self,"jumping")
	Input_Templete.connect("aim",self,"aim_val")
	cam.connect("not_aiming",self,"body_move_on_aim")
	Gravity= -ProjectSettings.get_setting("physics/3d/default_gravity")
	pass

func _physics_process(delta):
	camera = cam.cam.get_global_transform()
	move(delta)

func run(value):
	running =value
	
func aim_val(value,TIME):
	aim = value
	get_node("state_machine").aim =value
	if aim:
		get_node(object).rotation.y =cam.rotation.y

func input_link(dir):
	if dir.y >0:
		Dirction += -camera.basis[2]
	if dir.y <0:
		Dirction += camera.basis[2]
	if dir.x <0:
		Dirction += -camera.basis[0]
	if dir.x >0:
		Dirction += camera.basis[0]

func Gravity(time):

	if get_node("state_machine").on_air:
		Velocity.y += Gravity*2.0 * time 
	else:
		Velocity.y += Gravity * time

func body_move_on_aim(value):
	rotate_y(value)
func move(time = 0.0):
	Dirction = Dirction.normalized()
	
	if Dirction.x !=0 and Dirction.z != 0 and !aim and !get_parent().playerType == 3:
		var target =  Vector3(Dirction.x,0,Dirction.z)
		var q_from = Quat(get_node(object).global_transform.basis)
		var q_to = Quat(Transform().looking_at(-target,Vector3(0,1,0)).basis)
		get_node(object).global_transform.basis = Basis(q_from.slerp(q_to,time*ROTATION_INTERPOLATE_SPEED))
		get_node(object).global_transform.origin =self.global_transform.origin
		get_node(object).global_transform.orthonormalized()
	
	if Dirction.x != 0 or Dirction.z != 0:
		running_timer +=time
		if running_timer >3:
			running = true
	else:
		running_timer = 0.0
		running = false
	
	if running:
		Velocity.z = lerp(Velocity.z,Dirction.z * running_speed ,acel* time) 
		Velocity.x = lerp(Velocity.x,Dirction.x * running_speed ,acel* time)
	else:
		Velocity.z = lerp(Velocity.z,Dirction.z * speed ,acel* time) 
		Velocity.x = lerp(Velocity.x,Dirction.x * speed ,acel* time)
	
	Gravity(time)
	
	if is_on_floor() or raycast.is_colliding():
		var n =raycast.get_collision_normal()
		slope_angle= rad2deg(acos(n.dot(Vector3(0,1,0))))
		if slope_angle >slopeMax_angle:
			slope_angle = 0
		contact = true
		
	else:
		slope_angle =0
		contact = false
	
	Velocity = move_and_slide_with_snap(Velocity,Vector3(0,-1,0),Vector3(0,1,0),true,4,slope_angle)
	Dirction = Vector3()

func jumping():
	if contact or is_on_floor():
		Velocity.y = move_and_slide(Vector3(0,jump_hight,0),Vector3(0,1,0)).y
		get_node("state_machine").jump =true
		contact =false
	pass
