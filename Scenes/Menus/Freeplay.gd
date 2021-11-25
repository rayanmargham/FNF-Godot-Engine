extends Node2D

var lastSelected = -1

var selectedDifficulty = 2
var selectedSpeed = 1

var songData

var character1
var character2

var loadedJsons = {}
var loadedSongs = {}
var cur_name = "HE"

func _ready():
	get_songs()
	
	var songsMenu = $CanvasLayer/ChoiceMenu
	songsMenu.optionOffset.y = 120
	songsMenu.connect("option_selected", self, "song_chosen")
	
	song_selected(0)

func _process(_delta):
	if (Input.is_action_just_pressed("cancel")):
		SoundController.Play_sound("cancelMenu")
		SceneLoader.Load("res://Scenes/Menus/MainMenu.tscn")
		
	var move = int(Input.is_action_just_pressed("right")) - int(Input.is_action_just_pressed("left"))
	if (Input.is_key_pressed(KEY_SHIFT)):
		selectedSpeed += move * 0.1
	else:
		selectedDifficulty += move
		
	selectedDifficulty = clamp(selectedDifficulty, 0, SceneLoader.difficultys.size()-1)
		
	if ($CanvasLayer/ChoiceMenu.selected != lastSelected):
		song_selected($CanvasLayer/ChoiceMenu.selected)
		
	lastSelected = $CanvasLayer/ChoiceMenu.selected
	
	$CanvasLayer/SettingsBox/Label.text = "< " + SceneLoader.difficultys[selectedDifficulty] + " >\n" + cur_name

func get_songs():
	var songsMenu = $CanvasLayer/ChoiceMenu
	songsMenu.optionOffset.y = 120
	songsMenu.options = []
	
	var dir = Directory.new()
	dir.open("res://Assets/Songs/")
	
	dir.list_dir_begin()
	while true:
		var file = dir.get_next()
		if file == "":
			break
		elif not file.begins_with("."):
			songsMenu.options.append(file)
			if load("res://Assets/Songs/" + file + "/Inst.ogg") != null:
				
				loadedSongs[file] = load("res://Assets/Songs/" + file + "/Inst.ogg")
			loadedJsons[file] = MusicController.load_song_json(file)
			
	songsMenu.options.sort()
	
func setup_song_info():
	
	var infoString = ""
	if (songData.has("song")):
		infoString += str(songData["song"]) + "\n"
	if (songData.has("bpm")):
		infoString += "BPM: " + str(songData["bpm"]) + "\n"
	if (songData.has("speed")):
		infoString += "SPD: " + str(songData["speed"]) + "\n"
	
	infoString += "\n"	
	
	if (songData.has("stage")):
		infoString += "STG: " + str(songData["stage"]) + "\n"
	if (songData.has("player1")):
		infoString += "PLR: " + str(songData["player1"]) + "\n"
	if (songData.has("player2")):
		infoString += "ENMY: " + str(songData["player2"]) + "\n"
		

func song_selected(option):
	var songName = $CanvasLayer/ChoiceMenu.options[option]
	songData = loadedJsons[songName]
	cur_name = songName
	MusicController.play_song(loadedSongs[songName], songData["bpm"])
	
	var player1 = "test"
	var player2 = "test"
	
	if (songData.has("player1") && SceneLoader.CHARACTERS.has(songData["player1"])):
		player1 = songData["player1"]
	if (songData.has("player2") && SceneLoader.CHARACTERS.has(songData["player2"])):
		player2 = songData["player2"]
	
	if (character1 != null):
		character1.queue_free()
	character1 = SceneLoader.CHARACTERS[player1].instance()
	
	if (character2 != null):
		character2.queue_free()
	character2 = SceneLoader.CHARACTERS[player2].instance()
	
	setup_song_info()

func song_chosen(option):
	var songName = $CanvasLayer/ChoiceMenu.options[option]
	var difficulty = SceneLoader.difficultys[selectedDifficulty].to_lower()
	
	SceneLoader.change_playstate(songName, difficulty, selectedSpeed)
