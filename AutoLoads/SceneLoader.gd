extends Control

var scene = null
var target
var diff = "none"
var isweek = false
var failed = false
signal done
onready var animationplayer = $CanvasLayer/AnimationPlayer
# warnings-disable
const STAGES = {
	"stage": preload("res://Scenes/Stages/Week0.tscn"),
	"halloween": preload("res://Scenes/Stages/Spooky.tscn"),
	"lastroom": preload("res://Scenes/Stages/Mods/CyberFinal.tscn")
}
const CHARACTERS = {
#	"test": preload("res://Scenes/Objects/Character.tscn"),
	"bf": preload("res://Scenes/Characters/Boyfriend.tscn"),
	"gf": preload("res://Scenes/Characters/Girlfriend.tscn"),
	"dad": preload("res://Scenes/Characters/Dad.tscn"),
	"spooky": preload("res://Scenes/Characters/Spooky_Kids.tscn"),
	"taeyai": preload("res://Scenes/Characters/TaeYai.tscn")
}
var difficultys = ["EASY", "NORMAL", "HARD"]
func _ready():
	pause_mode = Node.PAUSE_MODE_PROCESS
func Load(param1):
	scene = param1
	diff = "none"
	isweek = false
	animationplayer.play("in")
func Load_Playstate(param):
	scene = param
	animationplayer.play("in_playstate")
func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "in":
		print(diff)
		if diff != "none":
			isweek = true
			MusicController.stop_song()
		if scene is Object == false:
			var scenetoload = load(scene)
			if ResourceLoader.exists(scene):
				print("nice im real")
				get_tree().change_scene_to(scenetoload)
				animationplayer.play("out")
				failed = false
				yield(animationplayer, "animation_finished")
				yield(get_tree().create_timer(0.1), "timeout") # extra timer so it does not crap itself
				emit_signal("done")
			else:
				failed = true
				print("failed")
				ErrorManager.HandleError(true, "Could Not Load JSON!")
		else:
			var scenetoload = scene
			print("nice im real")
			get_tree().change_scene_to(scenetoload)
			animationplayer.play("out")
			failed = false
	if anim_name == "in_playstate":
		get_tree().current_scene.queue_free()
		get_tree().get_root().add_child(scene)
		get_tree().current_scene = scene
		animationplayer.play("out")
			
func Load_Week(week, difficulty = 1, transition = true):
	scene = "res://Scenes/Stages/" + week + ".tscn"
	match difficulty:
		0:
			diff = "easy"
		1:
			diff = "normal"
		2:
			diff = "hard"
	if transition == false:
		var scenetoload = load(scene)
		get_tree().change_scene_to(scenetoload)
	else:
		animationplayer.play("in")
func ResetGame():
	get_tree().change_scene("res://Scenes/Menus/Splash.tscn")
	MusicController.stop_song()
	SoundController.Stop_all()
	SceneLoader.isweek = false
	Mapper.json = ""
func change_playstate(song, difficulty, speed = 1):
	var json = MusicController.load_song_json(song)
	
	# get the stage
	var scene 
	if (json.has("stage") && STAGES.has(json["stage"])):
		scene = STAGES[json["stage"]].instance()
	
	# get the players
	var player1
	var player2
	if (json.has("player1") && CHARACTERS.has(json["player1"])):
		player1 = CHARACTERS[json["player1"]]
	if (json.has("player2") && CHARACTERS.has(json["player2"])):
		player2 = CHARACTERS[json["player2"]]
		
	if (scene == null):
		match json["player2"]:
			"spooky":
				scene = STAGES["halloween"].instance()
				print("yes indeed")
			_:
				scene = STAGES["stage"].instance()
				print("No " + str(player2))
		
	scene.song = song
	scene.difficulty = difficulty
	scene.speed = speed
	
	if (player1 != null):
		scene.PlayerCharacter = player1
	if (player2 != null):
		scene.EnemyCharacter = player2
	scene.GFCharacter = CHARACTERS["gf"]
	
	SceneLoader.Load_Playstate(scene)
