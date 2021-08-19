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
	["SENPAI", "ROSES", "THORNS"],
	["CUM", "CUM", "CUM"]
]
var week_Titles = [
	["Tutorial"],
	["daddy cum"],
	["spooky"],
	["go pico"],
	["big boobies"],
	["chirmstas"],
	["hate simulator"],
	["CumMan"]
]
enum difficulty {
	EASY,
	NORMAL,
	HARD
}
var Selected_Week = week.TUTORIAL
var Selected_Difficulty = difficulty.NORMAL 
var lock = false
# Scrolling variable
onready var Initial_Weeks_Container_Position = $MainLayer/Weeks.rect_position

#=================Private Functions===============
func _input(event):
	# Difficulty Selector
	if event.is_action_pressed("ui_left"):
		if lock == false:
			$MainLayer/LeftArrow.frame = 1
			$MainLayer/DIfficulty/Hop.play("Hop")
			Selected_Difficulty = posmod(Selected_Difficulty-1, 3)
	if event.is_action_released("ui_left"):
		if lock == false:
			$MainLayer/LeftArrow.frame = 0
	if event.is_action_pressed("ui_right"):
		if lock == false:
			$MainLayer/RightArrow.frame = 1
			$MainLayer/DIfficulty/Hop.play("Hop")
			Selected_Difficulty = posmod(Selected_Difficulty+1, 3)
	if event.is_action_released("ui_right"):
		if lock == false:
			$MainLayer/RightArrow.frame = 0
		
	# Week Selector
	if event.is_action_pressed("ui_up"):
		if lock == false:
			SoundController.Play_sound("scrollMenu")
			Selected_Week = posmod(Selected_Week-1, 8)
	if event.is_action_pressed("ui_down"):
		if lock == false:
			SoundController.Play_sound("scrollMenu")
			Selected_Week = posmod(Selected_Week+1, 8)

	# Enter and Cancel
	if event.is_action_pressed("ui_cancel"):
		if lock == false:
			SoundController.Play_sound("cancelMenu")
			SceneLoader.Load("res://Scenes/Menus/MainMenu.tscn")
	if event.is_action_pressed("ui_accept"):
		if lock == false:
			SoundController.Play_sound("confirmMenu")
			$FrontLayer/Boyfriend.animation = "hey"
			
			match Selected_Difficulty:
				difficulty.EASY:
					lock = true
					print("Starting Week ", Selected_Week, " on Easy mode")
				difficulty.NORMAL:
					lock = true
					print("Starting Week ", Selected_Week, " on Normal mode")
				difficulty.HARD:
					lock = true
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
		
		
	match Selected_Week:
		0:
			$FrontLayer/Opponent.hide()
			$"FrontLayer/Track Title".text = week_Titles[0][0]
		1:
			$FrontLayer/Opponent.show()
			$"FrontLayer/Track Title".text = week_Titles[1][0]
		2:
			$"FrontLayer/Track Title".text = week_Titles[2][0]
		3:
			$"FrontLayer/Track Title".text = week_Titles[3][0]
		4:
			$"FrontLayer/Track Title".text = week_Titles[4][0]
		5:
			$"FrontLayer/Track Title".text = week_Titles[5][0]
		6:
			$"FrontLayer/Track Title".text = week_Titles[6][0]
		7:
			$"FrontLayer/Track Title".text = week_Titles[7][0]
	$MainLayer/Weeks.rect_position.y = lerp($MainLayer/Weeks.rect_position.y, Initial_Weeks_Container_Position.y-Selected_Week*87, 0.2 )

