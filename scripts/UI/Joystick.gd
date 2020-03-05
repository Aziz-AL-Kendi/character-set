extends TouchScreenButton


var radius
var boundary
var onGoing_drag =-1
export var de_accel = 20
export var limit = 10
signal joystick_phone

func _ready():
	radius = Vector2(shape.radius, shape.radius)
	boundary =get_parent().texture.get_width()/2

func get_button_position():
	return position + radius
func _process(delta):
	if onGoing_drag ==-1:
		var pos_defference = (Vector2(0,0) - radius) - position
		position += pos_defference * de_accel *delta
#	emit_signal("joystick_phone",set_Diraction())
		
func _input(event):
	if event is InputEventScreenDrag  or (event is InputEventScreenTouch and event.is_pressed()):
		var event_dist_from_center = (event.position - get_parent().global_position).length()
		
		if event_dist_from_center <= boundary * global_scale.x or event.get_index() == onGoing_drag:
			set_global_position(event.position -  radius * global_scale)
			if get_button_position().length() > boundary:
				set_position(get_button_position().normalized() * boundary -radius)
			onGoing_drag = event.get_index()
	if event is InputEventScreenTouch and !event.is_pressed() and event.get_index() ==onGoing_drag:
		onGoing_drag =-1
		pass
func set_Diraction():
	if get_button_position().length() > limit:
		return get_button_position().normalized()
	return Vector2(0,0)
