extends Control

const MAX_BUMPIN_FRAMES = 29 # How many frames the bumpin sprite has
const MAX_LOGO_FRAMES = 14
var prevent = false
var rotateamount = 7
func _ready():
	if MusicController.playing == false:
		var freaky = load("res://Assets/Menus/Music&Sounds/freakyMenu.ogg")
		MusicController.play_song(freaky, 102)
func _process(_delta):
	if MusicController.playing == true:
		# Bumpin animation
		$gflayer/gf.frame = round(MusicController.get_beat_time() * MAX_BUMPIN_FRAMES)
		$logo.frame = round(MusicController.get_half_beat_time() * MAX_LOGO_FRAMES)

func _input(event):
	if event.is_action_pressed("ui_accept"):
		SoundController.Play_sound("confirmMenu")
		$Flash/WhiteFlash/WhiteFlashFade.play("EnterFlash")
		$CanvasLayer/PressEnterText.animation = "selected"
		yield(get_node("Flash/WhiteFlash/WhiteFlashFade"), "animation_finished")
		SceneLoader.Load("res://Scenes/Menus/MainMenu.tscn")


