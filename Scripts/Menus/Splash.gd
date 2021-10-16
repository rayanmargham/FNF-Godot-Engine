extends Control
########################################
# This is the Splash screen and its the
# first scene to be loaded
########################################

# Animation Triggers
# warnings-disable
func Play_Sound():
	FpsCounter.HideCounter()
	SoundController.Play_sound("SplashSound")
func Switch_To_Into():
	SoundController.Stop_sound()
	var intro = load("res://Scenes/Menus/Intro.tscn")
	get_tree().change_scene_to(intro)
func transition_to_start():
	$Splash/Event_Anim.play("loadstart")
func start_load():
	while $ProgressBar.value != 100:
		$ProgressBar.value += 5
		# loading stuff for future
		yield(get_tree().create_timer(0.01), "timeout")
	print("done")
	$Splash/Event_Anim.play("loadend")
func _ready():
	if OS.window_fullscreen == true:
		OS.window_fullscreen = false
