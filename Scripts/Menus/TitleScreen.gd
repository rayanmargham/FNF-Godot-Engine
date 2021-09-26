extends Control

const MAX_BUMPIN_FRAMES = 29 # How many frames the bumpin sprite has
const MAX_LOGO_FRAMES = 14
var prevent = false
var rotateamount = 7
func _ready():
	if MusicController.playing == false:
		MusicController.Play_music()
func _process(_delta):
	if MusicController.playing == true:
		# Bumpin animation
		$gflayer/gf.frame = round(MusicController.GetBeatTime() * MAX_BUMPIN_FRAMES)
		$logo.frame = round(MusicController.GetHalfBeatTime() * MAX_LOGO_FRAMES)
		if round(MusicController.GetBeatTime()) == 1:
			if prevent == false:
				$logo/Tween.interpolate_property($logo, "rotation_degrees", rotateamount, -rotateamount, 0.5, Tween.TRANS_BACK, Tween.EASE_OUT)
				$logo/Tween.start()
				prevent = true
		else:
			if prevent == true:
				$logo/Tween.interpolate_property($logo, "rotation_degrees", -rotateamount, rotateamount, 0.5, Tween.TRANS_BACK, Tween.EASE_OUT)
				$logo/Tween.start()
				prevent = false

func _input(event):
	if event.is_action_pressed("ui_accept"):
		SoundController.Play_sound("confirmMenu")
		$Flash/WhiteFlash/WhiteFlashFade.play("EnterFlash")
		$CanvasLayer/PressEnterText.animation = "selected"
		yield(get_node("Flash/WhiteFlash/WhiteFlashFade"), "animation_finished")
		SceneLoader.Load("res://Scenes/Menus/MainMenu.tscn")


