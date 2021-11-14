extends Node2D

var valueData = null
var valueEditing = null
onready var optionsMenu = get_node("../../")

var specialType = null

var keyMode = false

var waitTime = 0

func _process(_delta):
	if (!visible):
		return
	
	if (waitTime > 0):
		waitTime -= 1 * _delta
		return
		
	change_value()
	
	if (keyMode):
		return
		
	if (Input.is_action_just_pressed("confirm")):
		Settings.set(valueData[0], valueEditing)
		close()
	
	if (Input.is_action_just_pressed("cancel")):
		SoundController.Play_sound("cancelMenu")
		close()
		
func _input(event):
	if (!visible):
		return
	
	if (keyMode):
		if (event is InputEventKey):
			if (event.pressed):
				var keys = InputMap.get_action_list(valueData[0])
				InputMap.action_erase_event(valueData[0], keys[keys.size()-1])
				InputMap.action_add_event(valueData[0], event)
				
				optionsMenu.waitTime = 0.2
				keyMode = false
				close()
		
func change_value():
	var fakeValue = valueEditing
	var ext = ""
	
	match (specialType):
		"key":
			var keys = InputMap.get_action_list(valueData[0])
			valueEditing = str(OS.get_scancode_string(keys[keys.size()-1].scancode))
		"percent":
			var move = int(Input.is_action_just_pressed("right")) - int(Input.is_action_just_pressed("left"))
			valueEditing += move * 0.05
			valueEditing = clamp(valueEditing, 0, 1)
			
			fakeValue *= 100
			ext = "%"
		"offset":
			ext = "ms"
	
	if (valueEditing is bool):
		if (Input.is_action_just_pressed("right") || Input.is_action_just_pressed("left")):
			valueEditing = !valueEditing
	
	if (valueEditing is int):
		var move = int(Input.is_action_just_pressed("right")) - int(Input.is_action_just_pressed("left"))
		var multi = 1
		if (Input.is_key_pressed(KEY_SHIFT)):
			multi = 10
			
		valueEditing += move * multi
	
	if (valueEditing is Vector2):
		var moveRL = int(Input.is_action_just_pressed("right")) - int(Input.is_action_just_pressed("left"))
		var moveDU = int(Input.is_action_just_pressed("down")) - int(Input.is_action_just_pressed("up"))
		var multi = 1
		if (Input.is_key_pressed(KEY_SHIFT)):
			multi = 10
		
		valueEditing.x += moveRL * multi
		valueEditing.y += moveDU * multi
			
	$Value.text = str(fakeValue) + ext

func close():
	optionsMenu.get_options()
	
	optionsMenu.enabled = true
	visible = false

func edit_value(_name):
	visible = true
	
	optionsMenu.enabled = false
	
	waitTime = 0.2
	valueData = optionsMenu.options[optionsMenu.pageName][_name]
	valueEditing = Settings.get(valueData[0])
	
	specialType = null
	if (valueData.size()-1 >= 3):
		specialType = valueData[3]
	
	$Value.text = str(valueEditing)
	$ValueName.text = _name
	
	change_other()
	change_value()
	
func change_other():
	if (specialType == null):
		if (valueEditing is int):
			$ValueInfo.text = "USE LEFT AND RIGHT\nSHIFT TO MOVE BY 10"
		if (valueEditing is Vector2):
			$ValueInfo.text = "USE ARROW KEYS\nSHIFT TO MOVE BY 10"
		else:
			$ValueInfo.text = "USE LEFT AND RIGHT"
	else:
		match (specialType):
			"key":
				keyMode = true
				$ValueInfo.text = "PRESS ANY KEY"
