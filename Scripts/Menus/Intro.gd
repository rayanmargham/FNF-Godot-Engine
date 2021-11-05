extends Control

#==========================Variables==========================
# Nodes/Scenes
onready var TopLabel = get_node("TopLabel")
onready var BottomLabel = get_node("BottomLabel")
var TitleMenu_scn = preload("res://Scenes/Menus/TitleScreen.tscn")
# warnings-disable
# Data
var Quote:Array # 0 is top word, 1 is bottom word

#==========================Private Functions==========================
func _ready():
	randomize()
	Quote = _Load_Random_Quote() # Set Quote after calling randomize
	# Start music
	var freaky = load("res://Assets/Menus/Music&Sounds/freakyMenu.ogg")
	MusicController.play_song(freaky, 102)
	MusicController.connect("quarter_hit", self, "_quarter")
	MusicController.connect("eighth_hit", self, "_lol")

func _input(event):
	# Skip intro if pressed Enter
	if event.is_action_pressed("ui_accept"):
		get_tree().change_scene_to(TitleMenu_scn)

func _Load_Random_Quote() -> Array:
	 ## Returns a random Quote for the Intro
	var all_Quotes = [] # Array of Arrays
	var f = File.new()
	f.open("res://Assets/JSON&Text_Files/IntroText.txt", File.READ)
	
	while not f.eof_reached():
		var splitted_quote = Array(f.get_line().split("--"))
		if not splitted_quote.empty() and splitted_quote[0] != "":
			all_Quotes.push_back([splitted_quote[0], splitted_quote[1]])
	
	f.close()
	return all_Quotes[randi()%all_Quotes.size()]
	
# Animation Triggers
func _generateTopWord():
	TopLabel.text = Quote[0]
func _generateBottomWord():
	BottomLabel.text = Quote[1]
func _switchToTitleMenu():
	get_tree().change_scene_to(TitleMenu_scn)

func _quarter(quarter):
	match quarter:
		0:
			print("ok")
		3:
			BottomLabel.set("custom_colors/font_color", Color(1, 1, 1, 1))
			BottomLabel.text = "the linux team"
		4:
			reset_labels()
		5:
			TopLabel.text = "MADE IN"
		7:
			BottomLabel.text = "GODOT"
			BottomLabel.set("custom_colors/font_color", Color(0.24, 0.58, 1, 1))
		8:
			reset_labels()
		9:
			_generateTopWord()
		11:
			_generateBottomWord()
		12:
			reset_labels()
		13:
			TopLabel.text = "F"
		14:
			TopLabel.text += "N"
		15:
			TopLabel.text += "F"
		16:
			_switchToTitleMenu()
	#print(quarter)
func reset_labels():
	BottomLabel.text = ""
	BottomLabel.set("custom_colors/font_color", Color(1, 1, 1, 1))
	TopLabel.text = ""
	TopLabel.set("custom_colors/font_color", Color(1, 1, 1, 1))
func _lol(lol):
	match lol:
		31:
			BottomLabel.text = "Godot Edition"
