tool
extends Node2D

enum Note {Left, Down, Up, Right}
export (Note) var note_type = Note.Left
export (int) var animFrame = 0

func _process(_delta):
	if not Engine.editor_hint:
		if (Resources.downScroll):
			scale.y = -1
	
	$Sprite.frame = animFrame + (note_type * 6)

func _on_AnimationPlayer_animation_finished(anim_name):
	if (anim_name == "hit"):
		$AnimationPlayer.play("idle")
