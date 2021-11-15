extends ChoiceMenu

onready var menu = get_node("../")

func _ready():
	optionOffset = Vector2(0, 80)
	
func move_option():
	if (menu.waitTime <= 0):
		.move_option()

func draw_options():
	var idx = 0
	for option in options:
		var sIdx = idx - selected
		
		var color = Color.darkgray
		if (selected == idx):
			color = Color.white
		
		var data = menu.options[menu.pageName][option]
		
		var string = get_string(data, option)
		
		if (!enabled):
			color = Color.webgray
		
		draw_string(FONT, position + Vector2((sIdx * optionsOffset.x) + 70, (sIdx * optionsOffset.y) + 320) + offset, string.to_upper(), color)
		idx += 1

func get_string(data, option):
	if (data.size()-1 >= 3):
		match (data[3]):
			"seperator":
				return ""
			"key":
				var keys = InputMap.get_action_list(data[0])
				return option + ": " + str(OS.get_scancode_string(keys[keys.size()-1].scancode))
			"percent":
				return option + ": " + str(Settings.get(data[0]) * 100)
	
	return option + ": " + str(Settings.get(data[0]))
