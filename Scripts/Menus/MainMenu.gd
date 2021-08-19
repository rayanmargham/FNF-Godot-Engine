extends Control

#=============Variables=============
var selected_Button = 0 # 0 - 2
onready var initial_BG_offset = $background.position.y
var disable = false
#=============Private Functions=============
func _input(event):
	if event.is_action_pressed("ui_down"):
		selected_Button = posmod(selected_Button + 1, 3)
		SoundController.Play_sound("scrollMenu")
	if event.is_action_pressed("ui_up"):
		selected_Button = posmod(selected_Button - 1, 3)
		SoundController.Play_sound("scrollMenu")
	if event.is_action_pressed("ui_cancel"):
		SoundController.Play_sound("cancelMenu")
		SceneLoader.Load("res://Scenes/Menus/TitleScreen.tscn")
	if event.is_action_pressed("ui_accept"):
		SoundController.Play_sound("confirmMenu")
		set_process_input(false)
		set_process(false)
		$background.playing = true
		$ExitTimer.start()
	if event.is_action_pressed("I"):
		if disable == false:
			print("NOTICE: NOTHING HERE FOR NOW")
			disable = true

func _process(_delta):
	# Scroll the BG
	$background.position.y = lerp($background.position.y, initial_BG_offset - selected_Button * 50, 0.1)
	
	match selected_Button:
		0:
			$Storymode.animation = "selected"
			$Freeplay.animation = "default"
			$options.animation = "default"
		1:
			$Storymode.animation = "default"
			$Freeplay.animation = "selected"
			$options.animation = "default"
		2:
			$Storymode.animation = "default"
			$Freeplay.animation = "default"
			$options.animation = "selected"

func _on_ExitTimer_timeout():
	match selected_Button:
		0:
			SceneLoader.Load("res://Scenes/Menus/StoryModeMenu.tscn")
		1:
			SceneLoader.Load("res://Scenes/Menus/Freeplay.tscn")
		2:
			SceneLoader.Load("res://Scenes/Menus/Options.tscn")
