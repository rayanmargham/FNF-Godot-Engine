extends Node2D

export var inGame = false

var options = {
		
	"GAMEPLAY": {
		"BOTPLAY": ["botPlay", "Plays the game for you lmfao.", true],
		"GHOST TAPPING": ["ghostTapping", "Allows you to press keys without losing health.", true],
		"HITSOUNDS": ["hitSounds", "Plays a sound every time you hit a note.", true],
		"STRUM POSITIONS": [null, "", false, "seperator"],
		"DOWNSCROLL": ["downScroll", "Makes the notes move down instead of up.", false],
		"MIDDLESCROLL": ["middleScroll", "Moves your strumline to the middle.", false],
		"ENEMY MIDDLESCROLL": ["middleScrollPreview", "Shows a smaller version of the enemys side on the left.", false],
		"LINUX SPLASH": ["Splash", "Disables the Splash at start-up.", true],
	},
	"APPEARENCE": {
		"HUD RATINGS": ["hudRatings", "Show the ratings on the HUD layer instead of the GAME layer.", true],
		"HUD RATINGS OFFSET": ["hudRatingsOffset", "Changes the on-screen position of the HUD Ratings.", true],
		"CAMERA MOVEMENT": ["cameraMovement", "Moves the camera depending on what notes been hit.", true],
		"BACKGROUND OPACITY": ["backgroundOpacity", "Darkens the game so you can focus on hitting notes. (tryhard)", true, "percent"],
	},
	"CONTROLS": {
		"LEFT": ["left", "", true, "key"],
		"DOWN": ["down", "", true, "key"],
		"UP": ["up", "", true, "key"],
		"RIGHT": ["right", "", true, "key"],
		"SEP1": [null, "", true, "seperator"],
		"CONFIRM": ["confirm", "", true, "key"],
		"CANCEL": ["cancel", "", true, "key"],
		"SEP2": [null, "", false, "seperator"],
		"OFFSET": ["offset", "Changes the offset of the notes.\n(Negative is late, Positive is early)", false, "offset"],
	}

}

var enabled = true
var waitTime = 0.1

var page = 0
onready var pageName = options.keys()[page]

var topBarOffset = 0
# Szviin

func _ready():
	get_options()
	
	var _select = $ChoiceMenu.connect("option_selected", self, "edit_option")
	
func _process(_delta):
	$ChoiceMenu.enabled = enabled
	
	if (!enabled):
		waitTime = 0.1
	else:
		if (waitTime > 0):
			waitTime -= 1 * _delta
			
	topBarOffset = lerp(topBarOffset, 0, 10 * _delta)
			
	if (enabled):
		if (waitTime <= 0):
			var move = int(Input.is_action_just_pressed("right")) - int(Input.is_action_just_pressed("left"))
			page += move
			
			if (page < 0):
				page = options.keys().size()-1
			if (page > options.keys().size()-1):
				page = 0
				
			pageName = options.keys()[page]
			
			if (move != 0):
				$ChoiceMenu.selected = 0
				topBarOffset = 200 * move
				get_options()
		
		var selectedOption = options[pageName][options[pageName].keys()[$ChoiceMenu.selected]]
		$DescriptionRect/Description.text = selectedOption[1]
		
		$TopBar/HBoxContainer/CurPage.text = pageName
		
		var nextPage = 0
		if (page + 1 < options.keys().size()):
			nextPage = page + 1
		$TopBar/HBoxContainer/NextPage.text = options.keys()[nextPage]
		$TopBar/HBoxContainer/LastPage.text = options.keys()[page - 1]
		
		$TopBar/HBoxContainer.rect_position.x = topBarOffset
	
func _exit_tree():
	Settings.save_settings()

func get_options():
	var choiceMenu = $ChoiceMenu
	choiceMenu.options = []
	
	for option in options[pageName].keys():
		var optionData = options[pageName][option]
		
		if (!inGame or optionData[2] == true):
			choiceMenu.options.append(option)  

func edit_option(selected):
	if (waitTime > 0):
		return
	
	var selectedName = options[pageName].keys()[selected]
	if (options[pageName][selectedName][0] != null):
		$EditValue/ValueEdit.edit_value(selectedName)
