extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var done = false
var selected = 0
var menupink = preload("res://backgrounds/menuBGMagenta.png")
var menublue = preload("res://backgrounds/menuBGBlue.png")
var menuyellow = preload("res://backgrounds/menuBG.png")
var g = 0
# Called when the node enters the scene tree for the first time.
#func _ready():
#	if selected == 0:
#		$Storymode.animation = "selected"
#		$Freeplay.animation = "default"
#		$options.animation = "default"
#	if selected == 1:
#		$Storymode.animation = "default"
#		$Freeplay.animation = "selected"
#		$options.animation = "default"
#	if selected == 2:
#		$Storymode.animation = "default"
#		$freeplay.animation = "default"
#		$options.animation = "selected"
func _input(event):
	if event.is_action_pressed("ui_down"):
		if done == false:
			SoundController.play_sound("res://Menu Resources/scrollMenu.ogg", false)
		if selected < 2:
			selected += 1
		else:
			selected = 0
	if event.is_action_pressed("ui_up"):
		if done == false:
			SoundController.play_sound("res://Menu Resources/scrollMenu.ogg", false)
		if selected > 0:
			selected -= 1
		else:
			selected = 2
	if event.is_action_pressed("ui_accept"):
		print("h")
		if done == false:
			done = true
			SoundController.play_sound("res://Menu Resources/confirmMenu.ogg", false)
			$Timer.start()
	if event.is_action_pressed("ui_cancel"):
		SoundController.play_sound("res://Menu Resources/cancelMenu.ogg", false)
		SceneLoader.Load("res://menu.tscn")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if done == false:
		if selected == 0:
			$Storymode.animation = "selected"
			$Freeplay.animation = "default"
			$options.animation = "default"
			#$Camera2D.set_follow("../Storymode")
			
		if selected == 1:
			$Storymode.animation = "default"
			$Freeplay.animation = "selected"
			$options.animation = "default"
			
		if selected == 2:
			$Storymode.animation = "default"
			$Freeplay.animation = "default"
			$options.animation = "selected"
			
	else:
		pass


func _on_Timer_timeout():
	match g:
		0:
			$background.set_texture(menupink)
		1:
			$background.set_texture(menuyellow)
		2:
			$background.set_texture(menupink)
		3:
			$background.set_texture(menuyellow)
		4:
			$background.set_texture(menupink)
		5:
			$background.set_texture(menuyellow)
			if selected == 0:
				SceneLoader.Load("res://Storymodemenu.tscn")
			if selected == 1:
				SceneLoader.Load("res://Freeplay.tscn")
			if selected == 2:
				SceneLoader.Load("res://Options.tscn")
	g += 1
