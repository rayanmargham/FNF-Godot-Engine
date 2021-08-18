extends Control

#=================Variables===============
enum week {
	TUTORIAL,
	WEEK1,
	WEEK2,
	WEEK3,
	WEEK4,
	WEEK5,
	WEEK6,
	WEEK7
}
var week_Tracks = [
	["TUTORIAL", "", ""],
	["BOPEEBO", "FRESH", "DADBATTLE"],
	["SPOOKEEZ", "SOUTH", "MONSTER"],
	["PICO", "PHILLY", "BLAMMED"],
	["SATIN-PANTIES", "HIGH", "MILF"],
	["COCOA", "EGGNOG", "WINTER-HORRORLAND"],
	["SEMPAI", "ROSES", "THORNS"],
	["UGH", "GUNS", "STRESS"]
]
enum difficulty {
	EASY,
	NORMAL,
	HARD
}
var Selected_Week = week.TUTORIAL
var Selected_Difficulty = difficulty.NORMAL 

# Scrolling variable
onready var Initial_Weeks_Container_Position = $MainLayer/Weeks.rect_position

#=================Private Functions===============
func _input(event):
	# Difficulty Selector
	if event.is_action_pressed("ui_left"):
		$MainLayer/LeftArrow.frame = 1
		$MainLayer/DIfficulty/Hop.play("Hop")
		Selected_Difficulty = posmod(Selected_Difficulty-1, 3)
	if event.is_action_released("ui_left"):
		$MainLayer/LeftArrow.frame = 0
	if event.is_action_pressed("ui_right"):
		$MainLayer/RightArrow.frame = 1
		$MainLayer/DIfficulty/Hop.play("Hop")
		Selected_Difficulty = posmod(Selected_Difficulty+1, 3)
	if event.is_action_released("ui_right"):
		$MainLayer/RightArrow.frame = 0
		
	# Week Selector
	if event.is_action_pressed("ui_up"):
		SoundController.Play_sound("scrollMenu")
		Selected_Week = posmod(Selected_Week-1, 8)
	if event.is_action_pressed("ui_down"):
		SoundController.Play_sound("scrollMenu")
		Selected_Week = posmod(Selected_Week+1, 8)
	

	# Enter and Cancel
	if event.is_action_pressed("ui_cancel"):
		SoundController.Play_sound("cancelMenu")
		SceneLoader.Load("res://Scenes/Menus/MainMenu.tscn")
	if event.is_action_pressed("ui_accept"):
		SoundController.Play_sound("confirmMenu")
		$FrontLayer/Boyfriend.animation = "hey"
		
		match Selected_Difficulty:
			difficulty.EASY:
				print("Starting Week ", Selected_Week, " on Easy mode")
			difficulty.NORMAL:
				print("Starting Week ", Selected_Week, " on Normal mode")
			difficulty.HARD:
				print("Starting Week ", Selected_Week, " on Hard mode")

func _process(_delta):
	# Set Bumpin animation on tempo
	var MAX_BF_FRAMES = 13
	var MAX_GF_FRAMES = 29
	var MAX_OPPONENT_FRAMES = 13
	$FrontLayer/Boyfriend.frame = round(MusicController.GetHalfBeatTime()*MAX_BF_FRAMES)
	$FrontLayer/Girlfriend.frame = round(MusicController.GetBeatTime()*MAX_GF_FRAMES)
	$FrontLayer/Opponent.frame = round(MusicController.GetHalfBeatTime()*MAX_OPPONENT_FRAMES)
	
	# Set Track Labels
	$MainLayer/TracksLabel/TrackList/Track1.text = week_Tracks[Selected_Week][0]
	$MainLayer/TracksLabel/TrackList/Track2.text = week_Tracks[Selected_Week][1]
	$MainLayer/TracksLabel/TrackList/Track3.text = week_Tracks[Selected_Week][2]
	
	# Set Difficulty
	$MainLayer/DIfficulty.frame = Selected_Difficulty
	
	# Set Weeks
	for i in $MainLayer/Weeks.get_child_count():
		if i == Selected_Week:
			$MainLayer/Weeks.get_child(i).modulate.a = 1
		else:
			$MainLayer/Weeks.get_child(i).modulate.a = 0.5
		
		
		
	$MainLayer/Weeks.rect_position.y = lerp($MainLayer/Weeks.rect_position.y, Initial_Weeks_Container_Position.y-Selected_Week*87, 0.2 )

