extends Control

#==========================Variables==========================
# Nodes
onready var TopLabel = get_node("TopLabel")
onready var BottomLabel = get_node("BottomLabel")
var intro = preload("res://menu.tscn")
# The random vars
var swag = load_file()
var numpicker = 0
#==========================Private Functions==========================
func _ready():
	randomize()
	# Start music
	MusicController.play_music("res://Menu Resources/freakyMenu.ogg", true)
func _input(event):
	# Skip intro if pressed Enter
	if event.is_action_pressed("ui_accept"):
		get_tree().change_scene_to(intro)


func _process(_delta):
	var time = MusicController.get_playback_position() + AudioServer.get_time_since_last_mix()
	time -= AudioServer.get_output_latency()
# Animation Functions
func _generateTopWord():
	swag.remove(0)
	print(swag)
	numpicker = rand_range(0, swag.size())
	TopLabel.text = swag[numpicker][0]
func _generateBottomWord():
	BottomLabel.text = swag[numpicker][1]
func _exit():
	get_tree().change_scene_to(intro)

func load_file():
	var f = File.new()
	f.open("res://Intro Resources/introText.txt", File.READ)
	var t = f.get_as_text()
#
	var firstarray = t.split("\n")
	var swagGoodArray = []
	for i in firstarray:
		swagGoodArray.push_front(i.split("--"))
	return swagGoodArray
