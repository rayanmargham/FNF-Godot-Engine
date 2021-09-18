extends Node

# Timestamps of frames rendered in the last second
var times := []

# Frames per second
var fps := 0
# DEBUG VAR THAT CAN BE ACCESSED FROM EVERYWHERE
var debug = true

func _process(_delta: float) -> void:
	var now := OS.get_ticks_msec()

	# Remove frames older than 1 second in the `times` array
	while times.size() > 0 and times[0] <= now - 1000:
		times.pop_front()

	times.append(now)
	fps = times.size()

	# Display FPS in the label
	$CanvasLayer/RichTextLabel.bbcode_text = "FPS: " + str(fps)
func _unhandled_input(event):
	if event.is_action_pressed("J"):
		if SceneLoader.isweek == false:
			print("DEBUG RESTART")
			get_tree().change_scene("res://Scenes/Menus/Splash.tscn")
			MusicController.Stop_music()
			SoundController.Stop_sound()
			SceneLoader.isweek = false
		else:
			if debug == false:
				print("DEBUG IS NOW ON")
				debug = true
			else:
				print("DEBUG IS NOW OFF")
				debug = false
func HideCounter():
	$CanvasLayer/RichTextLabel.hide()
func ShowCounter():
	$CanvasLayer/RichTextLabel.show()
