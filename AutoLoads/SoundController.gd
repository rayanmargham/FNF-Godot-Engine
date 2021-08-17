extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func play_sound(param1, param2):
	var target = load(param1)
	$Sound.stream = target
	$Sound.autoplay = param2
	$Sound.play()

func stop_sound():
	$Sound.stop()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
