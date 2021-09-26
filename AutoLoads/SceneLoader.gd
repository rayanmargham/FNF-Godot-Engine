extends Control

var scene = null
var target
var diff = "none"
var isweek = false
var failed = false
onready var animationplayer = $CanvasLayer/AnimationPlayer
func Load(param1):
	scene = param1
	diff = "none"
	isweek = false
	animationplayer.play("in")
func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "in":
		if isweek == true:
			MusicController.Stop_music()
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
			
func Load_Week(week, difficulty = "normal", transition = true):
	scene = "res://Scenes/Stages/" + week + ".tscn"
	diff = difficulty
	isweek = true
	if transition == false:
		var scenetoload = load(scene)
		get_tree().change_scene_to(scenetoload)
	else:
		animationplayer.play("in")
func ResetGame():
	get_tree().change_scene("res://Scenes/Menus/Splash.tscn")
	MusicController.Stop_music()
	SoundController.Stop_sound()
	SceneLoader.isweek = false
	Mapper.json = ""
