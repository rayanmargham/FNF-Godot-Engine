extends Control

onready var mes = ErrorManager.MESSAGE
onready var Texturerect = $CanvasLayer/TextureRect
onready var richtext = $CanvasLayer/RichTextLabel
var heis = false
var random = RandomNumberGenerator.new()
func _ready():
	Texturerect.visible = false
	richtext.visible = false
	print(ErrorManager.data.Fun)
	richtext.bbcode_text = """[shake][center]ERROR

""" + mes + "\nYOU MAY EXIT NOW"
	FpsCounter.HideCounter()
	yield(get_tree().create_timer(2), "timeout")
	if ErrorManager.data.Fun > 10:
		var his = load("res://Assets/Misc/ERROR/Audio/him.mp3")
		MusicController.play_song(his, 100)
		Texturerect.visible = true
		heis = true
	richtext.visible = true
	
	if ErrorManager.data.Fun == 10:
		MusicController.stop_song()
		richtext.bbcode_text = "[center]..."
		Texturerect.visible = false
		yield(get_tree().create_timer(5), "timeout")
		get_tree().quit()
	elif ErrorManager.data.Fun >= 10:
		if mes != "FUN IS INFINITE FUN IS INFINITE FUN IS INFINITE":
			richtext.bbcode_text = """[shake][center]

	""" + mes + "\nFUN IS INFINITE"
		else:
			richtext.bbcode_text = """[shake][center]

	""" + mes + "\n-LINUX TEAM"
func _process(delta):
	if heis == true:
		OS.window_position = Vector2(OS.window_position.x + random.randi_range(-1, 1), OS.window_position.y + random.randi_range(-1, 1))
func _input(event):
	if event.is_action_pressed("ui_cancel"):
		get_tree().quit()
	
