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
var week_strings = [
	"Tutorial",
	"Week1",
	"Week2",
	"Week3",
	"Week4",
	"Week5",
	"Week6",
	"Week7"
]
var week_Tracks = [
	["TUTORIAL", "", ""],
	["BOPEEBO", "FRESH", "DAD-BATTLE"],
	["SPOOKEEZ", "SOUTH", "MONSTER"],
	["PICO", "PHILLY", "BLAMMED"],
	["SATIN-PANTIES", "HIGH", "MILF"],
	["COCOA", "EGGNOG", "WINTER-HORRORLAND"],
	["SENPAI", "ROSES", "THORNS"],
	["CUM", "CUM", "CUM"]
]
var week_Titles = [
	["Tutorial"],
	["Daddy Dearest"],
	["Skid and Pump"],
	["Pico"],
	["Mummy Mearest"],
	["Red Snow"],
	["Hate Simulator"],
	["Tankman's Cum Session"]
]
enum difficulty {
	EASY,
	NORMAL,
	HARD
}
var difficulty_strings = [
	"easy",
	"normal",
	"hard"
]
var Selected_Week = week.TUTORIAL
var Selected_Difficulty = difficulty.NORMAL 
var lock = false
var opponent = "dad"

# Scrolling variable
onready var Initial_Weeks_Container_Position = $MainLayer/Weeks.rect_position

#=================Private Functions===============
func _input(event):
	# Difficulty Selector
	if event.is_action_pressed("ui_left"):
		if lock == false:
			$MainLayer/DifficultyNodes/LeftArrow.frame = 1
			$MainLayer/DifficultyNodes/DIfficulty/Hop.play("Hop")
			Selected_Difficulty = posmod(Selected_Difficulty-1, 3)
	if event.is_action_released("ui_left"):
		if lock == false:
			$MainLayer/DifficultyNodes/LeftArrow.frame = 0
	if event.is_action_pressed("ui_right"):
		if lock == false:
			$MainLayer/DifficultyNodes/RightArrow.frame = 1
			$MainLayer/DifficultyNodes/DIfficulty/Hop.play("Hop")
			Selected_Difficulty = posmod(Selected_Difficulty+1, 3)
	if event.is_action_released("ui_right"):
		if lock == false:
			$MainLayer/DifficultyNodes/RightArrow.frame = 0
		
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
			$FrontLayer/Boyfriend.play("hey")
			
			lock = true
			Resources.Week_Difficulty = difficulty_strings[Selected_Difficulty].to_lower()
			var dif = difficulty_strings[Selected_Difficulty].to_lower()
			#MusicController.stop_song()
			SceneLoader.change_playstate(week_Tracks[Selected_Week][0].to_lower(), dif)
			Resources.StoryMode = true
			Resources.StoryWeek = Selected_Week
			Resources.Track = week_Tracks[Selected_Week][0]
			Resources.Track_Number = 0
			Resources.Track_Length = week_Tracks[Selected_Week].size() - 1
			print("Week Track Amount: " + str(Resources.Track_Length))
			Resources.show_menu = false


func _process(_delta):
	# Set Bumpin animation on tempo
	# old way of idle (does not work with new conducter)
	var MAX_BF_FRAMES = 13
	var MAX_GF_FRAMES = 29
	var MAX_OPPONENT_FRAMES = 13

#	if $FrontLayer/Boyfriend.animation != "hey":
#		$FrontLayer/Boyfriend.frame = round(MusicController.get_half_beat_time()*MAX_BF_FRAMES)
#	$FrontLayer/Opponent.frame = round(MusicController.get_half_beat_time()*MAX_OPPONENT_FRAMES)
#	$FrontLayer/Girlfriend.frame = round(MusicController.beat_time*MAX_GF_FRAMES)
	# Set Track Labels
	$MainLayer/TracksLabel/TrackList/Track1.text = week_Tracks[Selected_Week][0]
	$MainLayer/TracksLabel/TrackList/Track2.text = week_Tracks[Selected_Week][1]
	$MainLayer/TracksLabel/TrackList/Track3.text = week_Tracks[Selected_Week][2]
	
	# Set Difficulty
	$MainLayer/DifficultyNodes/DIfficulty.frame = Selected_Difficulty
	
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
			$"FrontLayer/Track Title".rect_position.x = 300
	$MainLayer/Weeks.rect_position.y = lerp($MainLayer/Weeks.rect_position.y, Initial_Weeks_Container_Position.y-Selected_Week*87, 0.2 )

func _ready():
	if Resources.StoryMode:
		Resources.show_menu = false
		match Resources.StoryWeek:
			0:
				if Resources.Track_Number < Resources.Track_Length:
					print("nope your done")
					Resources.show_menu = true
			_:
				if Resources.Track_Number < Resources.Track_Length:
					Resources.Track_Number += 1
					print(Resources.Track_Number)
					print(Resources.StoryWeek)
					Resources.Track = week_Tracks[Resources.StoryWeek][Resources.Track_Number]
					print(week_Tracks[Resources.StoryWeek][Resources.Track_Number])
					SceneLoader.change_playstate(Resources.Track.to_lower(), Resources.Week_Difficulty)
				else:
					print("finished all songs lol")
					# do defaults
					Resources.Track = ""
					Resources.Track_Length = 3
					Resources.Track_Number = 0
					Resources.show_menu = true
	if Resources.show_menu:
		if not MusicController.playing:
			MusicController.stop_song()
			var freaky = load("res://Assets/Menus/Music&Sounds/freakyMenu.ogg")
			MusicController.play_song(freaky, 102)
			Resources.StoryMode = false
			#MusicController.play_song(freaky, 102)
		MusicController.connect("beat_hit", self, "_beat_hit")
		MusicController.connect("half_beat_hit", self, "_half_beat")
		Resources.reset_resource_data()
func _beat_hit():
	$FrontLayer/Opponent.frame = 0
	$FrontLayer/Boyfriend.frame = 0
	$FrontLayer/Boyfriend.play()
	$FrontLayer/Opponent.play()
func _half_beat():
	$FrontLayer/Girlfriend.play()
