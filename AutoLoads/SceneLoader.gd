extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var scene = null
var target
# Called when the node enters the scene tree for the first time.
func _ready():
	 pass# Replace with function body.

func Load(param1):
	scene = param1
	$transition/AnimationPlayer.play("in")
func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "in":
		get_tree().change_scene(scene)
		$transition/AnimationPlayer.play("out")
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
