extends Control

const MAX_BUMPIN_FRAMES = 29 # How many frames the bumpin sprite has
const MAX_LOGO_FRAMES = 14
var prevent = false
var rotateamount = 7
func _ready():
	if MusicController.playing == false:
		Resources.loadResources()
		var freaky = Resources.FreakyMenu
		MusicController.play_song(freaky, 102)
	MusicController.connect("beat_hit", self, "_bump")
func _process(_delta):
	if MusicController.playing == true:
		# Bumpin animation
#		$gflayer/gf.frame = round(MusicController.get_beat_time() * MAX_BUMPIN_FRAMES)
#		$logo.frame = round(MusicController.get_half_beat_time() * MAX_LOGO_FRAMES)
		pass

func _input(event):
	if event.is_action_pressed("ui_accept"):
		if prevent == false:
			prevent = true
			SoundController.Play_sound("confirmMenu")
			$Flash/WhiteFlash/WhiteFlashFade.play("EnterFlash")
			$CanvasLayer/PressEnterText.animation = "selected"
			yield(get_node("Flash/WhiteFlash/WhiteFlashFade"), "animation_finished")
			SceneLoader.Load("res://Scenes/Menus/MainMenu.tscn")


func _bump():
	$logo.frame = 0
	$logo.play()
