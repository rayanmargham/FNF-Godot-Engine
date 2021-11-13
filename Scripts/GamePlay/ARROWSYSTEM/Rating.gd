extends Node2D

var vsp = -200
var gravity = 1000

func _process(delta):
	position.y += vsp * delta
	vsp += gravity * delta
	
	if (vsp > 0):
		modulate.a -= 5 * delta
		
	if (modulate.a <= 0):
		queue_free()
