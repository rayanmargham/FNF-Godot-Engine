extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var disabled = false
var next = false
const MAX_LOGO_FRAMES = 15
# Called when the node enters the scene tree for the first time.
func _ready():
	FpsCounter.HideCounter()
	if ErrorManager.donealready == true:
		SceneLoader.ResetGame()
	else:
		MusicController.Play_music("Before The Story", 65)
		$AnimationPlayer.play("FadeIn")



func hoverbig(thing, tween):
	SoundController.Play_sound("first_button_hover")
	tween.interpolate_property(thing, "rect_scale", Vector2(1, 1), Vector2(1.05, 1.05), 0.1, Tween.TRANS_QUAD, Tween.EASE_IN)
	tween.start()
func hoversmall(thing, tween):
	SoundController.Play_sound("first_button_hover")
	tween.interpolate_property(thing, "rect_scale", Vector2(1.05, 1.05), Vector2(1, 1), 0.1, Tween.TRANS_QUAD, Tween.EASE_IN)
	tween.start()

func _on_Yes_mouse_entered():
	if disabled == false:
		hoverbig($CanvasLayer2/Yes, $CanvasLayer2/Yes/Tween)


func _on_Yes_mouse_exited():
	if disabled == false:
		hoversmall($CanvasLayer2/Yes, $CanvasLayer2/Yes/Tween)


func _on_No_mouse_entered():
	if disabled == false:
		hoverbig($CanvasLayer2/No, $CanvasLayer2/No/Tween)


func _on_No_mouse_exited():
	if disabled == false:
		hoversmall($CanvasLayer2/No, $CanvasLayer2/No/Tween)


func _on_Yes_button_up():
	if next == false:
		SoundController.Play_sound("first_button_selected")
		$AnimationPlayer.play_backwards("FadeIn")
		$CanvasLayer2/Yes.disabled = true
		$CanvasLayer2/No.disabled = true
		yield(get_tree().create_timer(2), "timeout")
		$notice2.text = """Do You Accept Funkin' WFC's TOS?"""
		$AnimationPlayer.play("TOS")
		next = true
		yield(get_tree().create_timer(1.5), "timeout")
		$CanvasLayer2/Yes.disabled = false
		$CanvasLayer2/No.disabled = false
		$Globe.play()
	else:
		SoundController.Play_sound("first_done")
		$AnimationPlayer.play_backwards("TOS")
		$CanvasLayer2/Yes.disabled = true
		$CanvasLayer2/No.disabled = true
		disabled = true
		MusicController.Stop_music()
		SoundController.connect("playing_done", self, "_go")
		SoundController.connect("playing_done_2", self, "_go")
		

func _go():
	SceneLoader.ResetGame()

func _on_No_button_up():
	SoundController.Play_sound("first_button_selected")
	if $CanvasLayer2/No.rect_scale == Vector2(1.05, 1.05):
		hoversmall($CanvasLayer2/No, $CanvasLayer2/No/Tween)
	disabled = true
	$CanvasLayer2/Yes.disabled = true
	$CanvasLayer2/No.disabled = true
	yield(get_tree().create_timer(0.2), "timeout")
	MusicController.Stop_music()
	if $BG/ColorRect.color != Color.black:
		$AnimationPlayer.play_backwards("TOS")
	else:
		$AnimationPlayer.play_backwards("FadeIn")
	SoundController.Play_sound("first_done")
	ErrorManager.reset_done()
	yield(get_tree().create_timer(5), "timeout")
	get_tree().quit()
