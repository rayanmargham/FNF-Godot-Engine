extends RichTextLabel


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

signal ok
# Called when the node enters the scene tree for the first time.
func _ready():
	pass
func _input(event):
	if event.is_action_pressed("ui_accept"):
		emit_signal("ok")
		SoundController.play_sound("res://Menu Resources/confirmMenu.ogg", false)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


#func _on_AnimationPlayer_animation_finished():
	#get_tree().change_scene("res://mainmenu.tscn") # Replace with function body.
