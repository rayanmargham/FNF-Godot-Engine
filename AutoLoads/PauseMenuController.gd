extends Node2D

var playState

var selectedDifficulty = 2
var selectedSpeed = 1
var difficultys = ["EASY", "NORMAL", "HARD"]

var options = ["RESUME", "RESTART SONG", "TOGGLE BOTPLAY", "OPTIONS", "EXIT TO TITLE"]

func _ready():
	#var _c_loaded = get_tree().current_scene.connect("scene_loaded", self, "_scene_loaded")
	
	playState = get_tree().current_scene
	$CanvasLayer/Options.options = options
	
	var label = $CanvasLayer/Label
	$Tween.interpolate_property(label, "rect_position:y", -100, label.rect_position.y, 1.6, Tween.TRANS_QUAD, Tween.EASE_IN_OUT)
	$Tween.interpolate_property(label, "modulate:a", 0, 1, 1.6, Tween.TRANS_QUAD, Tween.EASE_IN_OUT)
	$Tween.start()

func _process(_delta):
	if (get_tree().paused == false):
		queue_free()
		
	if (Input.is_action_just_pressed("cancel")):
		get_tree().paused = false
		
	pause_text_process()

func option_selected(selected):
	match (selected):
		0:
			get_tree().paused = false
		1:
			playState.restart_playstate()
		2:
			Resources.botPlay = !Resources.botPlay
		4:
			get_tree().paused = false
			MusicController.stop_song()
			Resources.reset_resource_data()
			SceneLoader.Load("res://Scenes/Menus/StoryModeMenu.tscn")
			
func pause_text_process():
	var pauseText = playState.song.capitalize() + "\n" + playState.difficulty.to_upper() + "\n" + str(playState.speed) + "x"
	
	match ($CanvasLayer/Options.selected):
		2:
			pauseText = str(Resources.botPlay).to_upper()
	
	$CanvasLayer/Label.text = pauseText

# not sure what this does so ima just comment it out lmao
#func _scene_loaded():
#	get_tree().paused = false


