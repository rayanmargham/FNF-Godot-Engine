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
	"stage": preload("res://Scenes/Stages/Week0.tscn")
}
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
func change_playstate(song, difficulty, speed = 1, stage = null):
	print(difficulty)
	print(song)
	var json = MusicController.load_song_json(song)
	
	var scene
	if (stage == null):
		var songStage = "stage"
		if (json.has(["stage"]) && STAGES.has(json["stage"])):
			songStage = json["stage"]
			
		scene = STAGES[songStage].instance()
		print(scene)
	else:
		scene = load(scene).instance()
		
	scene.song = song
	print(scene.song)
	scene.difficulty = difficulty
	scene.speed = speed
	
	SceneLoader.Load_Playstate(scene)
