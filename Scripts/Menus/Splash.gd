extends Control
########################################
# This is the Splash screen and its the
# first scene to be loaded
########################################

# Animation Triggers
func Play_Sound():
	SoundController.Play_sound("SplashSound")
func Switch_To_Into():
	SoundController.Stop_sound()
	var intro = load("res://Scenes/Menus/Intro.tscn")
	get_tree().change_scene_to(intro)
func _ready():
	if OS.window_fullscreen == true:
		OS.window_fullscreen = false
