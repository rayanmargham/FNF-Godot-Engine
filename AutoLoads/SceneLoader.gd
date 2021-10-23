extends Control

var scene = null
var target
var diff = "none"
var isweek = false
var failed = false
onready var animationplayer = $CanvasLayer/AnimationPlayer
# warnings-disable
func Load(param1):
	scene = param1
	diff = "none"
	isweek = false
	animationplayer.play("in")
func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "in":
		print(diff)
		if diff != "none":
			isweek = true
			MusicController.stop_song()
		var scenetoload = load(scene)
		if ResourceLoader.exists(scene):
			print("nice im real")
			get_tree().change_scene_to(scenetoload)
			animationplayer.play("out")
			failed = false
		else:
			failed = true
			print("failed")
			ErrorManager.HandleError(true, "Could Not Load JSON!")
			
func Load_Week(week, difficulty = 1, transition = true):
	scene = "res://Scenes/Stages/" + week + ".tscn"
	match difficulty:
		0:
			diff = "easy"
		1:
			diff = "normal"
		2:
			diff = "hard"
	if transition == false:
		var scenetoload = load(scene)
		get_tree().change_scene_to(scenetoload)
	else:
		animationplayer.play("in")
func ResetGame():
	get_tree().change_scene("res://Scenes/Menus/Splash.tscn")
	MusicController.stop_song()
	SoundController.Stop_all()
	SceneLoader.isweek = false
	Mapper.json = ""
