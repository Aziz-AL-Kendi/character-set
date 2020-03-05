extends KinematicBody

# set by emitter
var speed = 0
var damage = 0
var raycast_mode :bool
export (PackedScene)var sparks
var time_alive=5
var direction = Vector3(0,0,1)
var LIFESPAN =10


func _process(delta):
	var col = move_and_collide(delta * global_transform.basis.x * speed)

	if (col):
		if (col.collider and col.collider.has_method("damage")):
			if !raycast_mode:
				col.collider.damage(damage)
		create_hit_effects()
		queue_free()
	time_alive += delta
	if time_alive > LIFESPAN:
		queue_free()

func create_hit_effects():
	var new_sparks = sparks.instance()
	get_tree().get_root().add_child(new_sparks)
	new_sparks.global_transform = global_transform
	new_sparks.emitting = true
