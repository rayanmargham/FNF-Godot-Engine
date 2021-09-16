extends Control

var scene = null
var target
var diff = "none"
var isweek = false
func Load(param1):
	scene = param1
	diff = "none"
	isweek = false
	$transition/AnimationPlayer.play("in")
func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "in":
		if isweek == true:
			MusicController.Stop_music()
		var scenetoload = load(scene)
		if ResourceLoader.exists(scene):
			print("nice im real")
			get_tree().change_scene_to(scenetoload)
			$transition/AnimationPlayer.play("out")
		else:
			ErrorManager.HandleError(true, "Could Not Load JSON!")
			
func Load_Week(week, difficulty = "normal", transition = true):
	scene = "res://Scenes/Stages/" + week + ".tscn"
	diff = difficulty
	isweek = true
	if transition == false:
		var scenetoload = load(scene)
		get_tree().change_scene_to(scenetoload)
	else:
		$transition/AnimationPlayer.play("in")
