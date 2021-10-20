extends Node

########################################
# This Autoload is for managing sound
# and easy sound playing.
########################################
var sound_array = []
signal finished_sound
#var search_num = 0
func _ready():
	pass

func Play_sound(sound = "SplashSound"):
	#Type the sound you want and it will search it for you
	
	var target = null
	var volume = 0.5
	var temp_name = ""
	match sound:
		"cancelMenu":
			temp_name = sound
			#this are 1
			target = load("res://Assets/Menus/Music&Sounds/cancelMenu.wav")
		"confirmMenu":
			temp_name = sound
			#this are 1
			target = load("res://Assets/Menus/Music&Sounds/confirmMenu.wav")
		"scrollMenu":
			temp_name = sound
			#this are 1
			target = load("res://Assets/Menus/Music&Sounds/scrollMenu.wav")
		"SplashSound":
			temp_name = sound
			#this are 1
			volume = 20
			target = load("res://Assets/Menus/Music&Sounds/SplashSound.wav")
		"Alert":
			target = load("res://Assets/Menus/Music&Sounds/Alert.wav")
			# go on 30
			volume = 30
		"first_button_hover":
			temp_name = sound
			target = load("res://Misc/FirstUse/Sounds/ui_button_hover.wav")
		"first_button_selected":
			temp_name = sound
			target = load("res://Misc/FirstUse/Sounds/ui_button_selected.wav")
		"first_done":
			temp_name = sound
			target = load("res://Misc/FirstUse/Sounds/ui_done.wav")
		_:
			print("ERROR: Could not play sound: ", sound)
			return
	var temp_sound = AudioStreamPlayer.new()
	var sound_info = []
	temp_sound.stream = target
	temp_sound.volume_db = volume
	sound_info.append(temp_sound)
	# name should be at 1 in the sound info array
	# you can just search for them lol
	sound_info.append(temp_name)
	sound_array.append(sound_info)
	add_child(temp_sound)
	temp_sound.play()
	yield(temp_sound,"finished")
	emit_signal("finished_sound")
	remove_child(temp_sound)
	sound_array.erase(sound_info)
func Stop_sound(thingtofind = "SplashSound"):
	var search_num = 0
	if sound_array.size() != 0:
		while sound_array[search_num][1] != thingtofind and search_num <= sound_array.size():
			search_num += 1
		sound_array[search_num][0].stop()
		sound_array.remove(search_num)
func Stop_all():
	var search_num = 0
	if sound_array.size() != 0:
		while search_num <= sound_array.size():
			if sound_array[search_num][0]:
				remove_child(sound_array[search_num][0])
				sound_array.remove(search_num)
			search_num += 1
