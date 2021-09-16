extends Control

onready var mes = ErrorManager.MESSAGE
func _ready():
	$TextureRect.visible = false
	$RichTextLabel.visible = false
	
	$RichTextLabel.bbcode_text = """[shake][center]ERROR

""" + mes + "\nYOU MAY EXIT NOW"
	FpsCounter.HideCounter()
	yield(get_tree().create_timer(2), "timeout")
	if ErrorManager.data.Fun > 10:
		MusicController.Play_music("ERROR")
		$TextureRect.visible = true
	$RichTextLabel.visible = true
	
	if ErrorManager.data.Fun == 10:
		MusicController.Stop_music()
		$RichTextLabel.bbcode_text = "[center]..."
		$TextureRect.visible = false
		yield(get_tree().create_timer(5), "timeout")
		get_tree().quit()
	elif ErrorManager.data.Fun >= 10:
		$RichTextLabel.bbcode_text = """[shake][center]

""" + mes + "\nFUN IS INFINITE"

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		get_tree().quit()
	
