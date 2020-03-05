
tool 
extends ranger


func _ready():
	pass

func action():
	$AnimationPlayer.play("shot")
	yield($AnimationPlayer,"animation_finished")
