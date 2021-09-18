extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var isup = false
var command = ""
# Called when the node enters the scene tree for the first time.
func _ready():
	pass
func _input(event):
	if event.is_action_pressed("DEBUG_KEY"):
		if isup == false:
			$LineEdit/AnimationPlayer.play("up")
			isup = true
		elif isup == true:
			$LineEdit/AnimationPlayer.play("down")
			isup = false
func _process(delta):
	if $LineEdit.text == "LOAD":
		$LineEdit.text = ""
		command = "SCENE"
		$LineEdit.placeholder_text = "SCENE TO LOAD?"


func _on_LineEdit_text_entered(new_text):
	match command:
		"SCENE":
			var attempt = load($LineEdit.text)
			if attempt:
				print("cool")
			else:
				print("FAILED")
				$LineEdit.placeholder_text = "FAILED TO LOAD THAT SCENE"
				$LineEdit.text = ""
				yield(get_tree().create_timer(1), "timeout")
				$LineEdit.placeholder_text = ""
