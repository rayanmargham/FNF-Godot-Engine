extends Control

#==========================Variables==========================
# Nodes/Scenes
onready var TopLabel = get_node("TopLabel")
onready var BottomLabel = get_node("BottomLabel")
var TitleMenu_scn = preload("res://Scenes/Menus/TitleScreen.tscn")

# Data
var Quote:Array # 0 is top word, 1 is bottom word

#==========================Private Functions==========================
func _ready():
	randomize()
	Quote = _Load_Random_Quote() # Set Quote after calling randomize
	# Start music
	MusicController.Play_music("freakyMenu")

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

