extends Node


# Songs
var FreakyMenu:Resource

# Sounds
var cancelMenu:Resource
var confirmMenu:Resource
var intro3:Resource
var intro2:Resource
var intro1:Resource
var LinuxSplash:Resource
var introGo:Resource
var scrollMenu:Resource
var SplashSound:Resource
var Alert:Resource
var first_button_hover:Resource
var first_button_selected:Resource
var first_done:Resource

var StoryMode = false
var StoryWeek = 0
var Track = ""
var Track_Number = 0
var Track_Length = 2
var show_menu = true
var Week_Difficulty = "hard"

func reset_resource_data():
	Resources.StoryMode = false
	Resources.show_menu = true
	Resources.StoryWeek = 0
	Resources.Track = ""
	Resources.Track_Number = 0
	Resources.Track_Length = 2
	Resources.Week_Difficulty = "hard"


func loadResources(JsonContainingLocations = "res://Assets/JSON&Text_Files/ResourceLocations.json"):
	# you would do this in godot 4
#	var json = JSON.new()
#	var jsonObject = json.parse(load(JsonContainingLocations))
#	var json_complete = json.get_data()
	var file = File.new()
	file.open(JsonContainingLocations, File.READ)
	var json = file.get_as_text()
	var json_complete = parse_json(json)
	cancelMenu = load(json_complete.Sounds.cancelMenu)
	confirmMenu = load(json_complete.Sounds.confirmMenu)
	intro3 = load(json_complete.Sounds.intro3)
	intro2 = load(json_complete.Sounds.intro2)
	intro1 = load(json_complete.Sounds.intro1)
	introGo = load(json_complete.Sounds.introGo)
	scrollMenu = load(json_complete.Sounds.scrollMenu)
	Alert = load(json_complete.Sounds.Alert)
	FreakyMenu = load(json_complete.Songs.FreakyMenu)
func loadRequiredResources(JsonContainingLocations = "res://Assets/JSON&Text_Files/ResourceLocations.json"):
	var file = File.new()
	file.open(JsonContainingLocations, File.READ)
	var json = file.get_as_text()
	var json_complete = parse_json(json)
	first_button_hover = load(json_complete.Sounds.first_button_hover)
	first_button_selected = load(json_complete.Sounds.first_button_selected)
	first_done = load(json_complete.Sounds.first_done)
	SplashSound = load(json_complete.Sounds.SplashSound)
	LinuxSplash = load(json_complete.Sounds.LinuxSplash)
func _ready():
	loadRequiredResources()
