extends Control

var scene = null
var target

func Load(param1):
	scene = param1
	$transition/AnimationPlayer.play("in")
func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "in":
		var scenetoload = load(scene)
		$transition/AnimationPlayer.play("out")
		get_tree().change_scene_to(scenetoload)
