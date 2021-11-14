extends Node

var botPlay = false # plays the players side automatically
var ghostTapping = false # allows the player to press keys without the miss penalty
var hitSounds = false # play a sound when the player hits a note

var hudRatings = false # display ratings on the hud layer
var hudRatingsOffset = Vector2(640, 360) # if its a hud rating, move it by this offset
var backgroundOpacity = 0

var middleScroll = false
var middleScrollPreview = false
var downScroll = false
var Splash = true

var cameraMovement = true

var offset = 0

func _ready():
	load_settings()

func save_settings():
	var file = ConfigFile.new()
	
	var propertys = get_script().get_script_property_list()
	for property in propertys:
		var propName = property["name"]
		file.set_value("settings", propName, get(propName))
	
	file.save("user://settings.ini")
	
	save_keybinds()
	
func save_keybinds():
	var file = ConfigFile.new()
	
	var actions = InputMap.get_actions()
	for action in actions:
		var actionList = InputMap.get_action_list(action)
		var lastKey = actionList[actionList.size()-1]
		
		if (lastKey is InputEventKey):
			file.set_value("keybinds", action, actionList[actionList.size()-1].scancode)

	file.save("user://keybinds.ini")
	
func load_settings():
	var file = ConfigFile.new()
	var err = file.load("user://settings.ini")
	
	if err != OK:
		return
		
	for key in file.get_section_keys("settings"):
		set(key, file.get_value("settings", key, get(key)))
		
	load_keybinds()

func load_keybinds():
	var file = ConfigFile.new()
	var err = file.load("user://keybinds.ini")
	
	if err != OK:
		return
		
	for action in file.get_section_keys("keybinds"):
		var keys = InputMap.get_action_list(action)
		var scancode = file.get_value("keybinds", action, keys[keys.size()-1].scancode)

		var key = InputEventKey.new()
		key.set_scancode(scancode)
		
		InputMap.action_erase_event(action, keys[keys.size()-1])
		InputMap.action_add_event(action, key)
