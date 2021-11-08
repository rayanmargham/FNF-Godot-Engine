extends Node

########################################
# This Autoload is for managing sound
# and easy sound playing.
########################################
signal finished_sound
# adding a smart thing
#var search_num = 0
func _ready():
	$GarbageCollectionTimer.connect("timeout", self, "_Garbage_Collect")

func Play_sound(sound = "LinuxSplash"):
	#Type the sound you want and it will search it for you
	
	var target = null
	var volume = 0.5
	match sound:
		"cancelMenu":
			#this are 1
			target = Resources.cancelMenu
		"confirmMenu":
			#this are 1
			target = Resources.confirmMenu
		"intro3":
			
			target = Resources.intro3
		"intro2":
			
			target = Resources.intro2
		"intro1":
			
			target = Resources.intro1
		"LinuxSplash":
			
			target = Resources.LinuxSplash
			volume = 5
		"introGo":
			
			target = Resources.introGo
		"scrollMenu":
			
			#this are 1
			target = Resources.scrollMenu
		"SplashSound":
			
			#this are 1
			volume = 20
			target = Resources.SplashSound
		"Alert":
			target = Resources.Alert
			# go on 30
			volume = 30
		"first_button_hover":
			
			target = Resources.first_button_hover
		"first_button_selected":
			
			target = Resources.first_button_selected
		"first_done":
			
			target = Resources.first_done
		_:
			print("ERROR: Could not play sound: ", sound)
			return
		
	var new_sound = AudioStreamPlayer.new()
	new_sound.stream = target
	add_child(new_sound)
	new_sound.play()
	yield(new_sound, "finished")
	emit_signal("finished_sound")
	
func Stop_sound(thingtofind = "Assets/Menus/Music&Sounds/LinuxSplash.wav"):
	for i in get_children():
		if i:
			if i.name.begins_with("@"):
				if i.stream == load("res://" + thingtofind):
					i.stop()
func Stop_all():
	for i in get_children():
		if i:
			if i.name.begins_with("@"):
				i.stop()
func Set_Garbage_Collection_WaitTime(GarbageCollectionWait):
	$GarbageCollectionTimer.wait_time = GarbageCollectionWait
func _Garbage_Collect():
	print("Garbage Collection: Started" )
	for i in get_children():
		if i:
			if i.name.begins_with("@"):
				if i.playing != true:
					i.queue_free()
					print("Garbage Collection: Cleared Sound")
func Search_for_sound(stream):
	for i in get_children():
		if i:
			if i.name.begins_with("@"):
				if i.stream == stream:
					return i
			
