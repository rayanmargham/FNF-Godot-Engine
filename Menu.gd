extends Control

const MAX_BUMPIN_FRAMES = 29 # How many frames the bumpin sprite has

func _process(_delta):
	# Bumpin animation
	$Bumpin.frame = round(MusicController.GetBeatTime() * MAX_BUMPIN_FRAMES)

func _input(event):
	if event.is_action_pressed("ui_accept"):
		$PressEnterText.animation = "selected"
		SceneLoader.Load("res://mainmenu.tscn")
		SoundController.play_sound("res://Menu Resources/confirmMenu.ogg", false)

