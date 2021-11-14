tool
extends Node2D

enum Note {Left, Down, Up, Right}
export (Note) var note_type = Note.Left
export (int) var animFrame = 0
var enemyStrum = false

func _process(_delta):
	if not Engine.editor_hint:
		if (Settings.downScroll):
			scale.y = -1
	
	$Sprite.frame = animFrame + (note_type * 6)

func _on_AnimationPlayer_animation_finished(anim_name):
	if (!enemyStrum && !Settings.botPlay):
		return
		
	if (anim_name == "hit"):
		$AnimationPlayer.play("idle")
