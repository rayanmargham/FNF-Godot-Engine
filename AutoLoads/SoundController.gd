extends Node

########################################
# This Autoload is for managing sound
# and easy sound playing.
########################################
signal playing_done
signal playing_done_2
func _ready():
	$Sound.connect("finished", self, "_perform_1")
	$Sound2.connect("finished", self, "_perform_2")
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
		"first_button_hover":
			target = load("res://Misc/FirstUse/Sounds/ui_button_hover.wav")
		"first_button_selected":
			target = load("res://Misc/FirstUse/Sounds/ui_button_selected.wav")
		"first_done":
			target = load("res://Misc/FirstUse/Sounds/ui_done.wav")
		_:
			print("ERROR: Could not play sound: ", sound)
			return
	if $Sound.playing == true:
		$Sound2.stream = target
		$Sound2.play()
	elif $Sound.playing == false:
		$Sound.stream = target
		$Sound.play()
func Stop_sound():
	$Sound.stop()

func _perform_1():
	emit_signal("playing_done")
func _perform_2():
	emit_signal("playing_done_2")
