extends Node

########################################
# This Autoload is for managing sound
# and easy sound playing.
########################################

func Play_sound(sound = "SplashSound"):
	#Type the sound you want and it will search it for you
	
	var target = null
	match sound:
		"cancelMenu":
			$Sound.volume_db = 1
			target = load("res://Assets/Menus/Music&Sounds/cancelMenu.wav")
		"confirmMenu":
			$Sound.volume_db = 1
			target = load("res://Assets/Menus/Music&Sounds/confirmMenu.wav")
		"scrollMenu":
			$Sound.volume_db = 1
			target = load("res://Assets/Menus/Music&Sounds/scrollMenu.wav")
		"SplashSound":
			$Sound.volume_db = 1
			target = load("res://Assets/Menus/Music&Sounds/SplashSound.wav")
		"Alert":
			target = load("res://Assets/Menus/Music&Sounds/Alert.wav")
			$Sound.volume_db = 30
		_:
			print("ERROR: Could not play sound: ", sound)
			return
	$Sound.stream = target
	$Sound.play()
	
func Stop_sound():
	$Sound.stop()

