extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func play_music(param1, param2):
	var target = load(param1)
	$Music.stream = target
	$Music.autoplay = param2
	$Music.play()

func stop_music():
	$Music.stop()
func get_playback_position():
	return $Music.get_playback_position()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
