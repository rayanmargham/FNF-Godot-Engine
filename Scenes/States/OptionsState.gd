extends Node2D

func _process(_delta):
	if (!$OptionsMenu.enabled):
		return
	
	if (Input.is_action_just_pressed("cancel")):
		SoundController.Play_sound("cancelMenu")
		SceneLoader.Load("res://Scenes/Menus/MainMenu.tscn")
