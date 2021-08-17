extends Control

var intro = preload("res://start.tscn")

var g = 0


func _ready():
	$Splash/AnimationPlayer.stop(true)
	SoundController.stop_sound()
	MusicController.stop_music()
	SoundController.play_sound("res://HaxeFlixel intro.ogg", false)
	$Timer.start()

func _on_Timer_timeout():
	match g:
		2:
			$Splash.visible = true
			$Splash/AnimationPlayer.play("Splash")
		23:
			$Splash.visible = false
		30:
			get_tree().change_scene_to(intro)
	g += 1
