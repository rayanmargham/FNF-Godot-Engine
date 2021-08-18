extends Control

const MAX_BUMPIN_FRAMES = 29 # How many frames the bumpin sprite has

func _process(_delta):
	# Bumpin animation
	$Bumpin.frame = round(MusicController.GetBeatTime() * MAX_BUMPIN_FRAMES)

func _input(event):
	if event.is_action_pressed("ui_accept"):
		SoundController.Play_sound("confirmMenu")
		$PressEnterText.animation = "selected"
		yield(get_tree().create_timer(0.5), "timeout")
		SceneLoader.Load("res://Scenes/Menus/MainMenu.tscn")


