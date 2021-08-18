extends Control

var scene = null
var target

func Load(param1):
	scene = param1
	$transition/AnimationPlayer.play("in")
func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "in":
		get_tree().change_scene(scene)
		$transition/AnimationPlayer.play("out")
