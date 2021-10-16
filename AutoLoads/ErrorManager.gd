extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
const SAVE_DIR = "user://FNF/"
var MESSAGE = "FUN IS INFINITE"
var save_path = SAVE_DIR + "FUN.json"
var donealready = false
var data = {
	"Fun" : 0,
	"Done": 0,
}
var dialog = AcceptDialog.new()
var canvaslayer = CanvasLayer.new()
# warnings-disable
# Called when the node enters the scene tree for the first time.
func _ready():
	
	var dir = Directory.new()
	add_child(canvaslayer)
	dialog.add_button("Reload", true, "lmao")
	dialog.connect("custom_action", self, "_what")
	dialog.connect("confirmed", self, "_oof")
	canvaslayer.layer = 1
	dialog.pause_mode = dialog.PAUSE_MODE_PROCESS
	dialog.popup_exclusive = true
	if !dir.dir_exists(SAVE_DIR):
		dir.make_dir_recursive(SAVE_DIR)
	var file = File.new()
	if file.file_exists(save_path):
		print("hello?")
		var dat = loadjson()
		if dat.Done == 0:
			dat.Done += 1
			print("its false")
			donealready = false
		else:
			print("its true")
			donealready = true
		savejson(data)
	else:
		createjson(data)
		var dat = loadjson()
		if dat.Done == 0:
			print("false")
			donealready = false
		else:
			print("true")
			donealready = true
func createjson(dat):
	var file = File.new()
	var error = file.open(save_path, File.WRITE)
	if error == OK:
		file.store_line(JSON.print(dat))
		file.close()
		return dat
func HandleError(ErrorScreen,ErrorMessage):
	if ErrorScreen == true:
		MESSAGE = ErrorMessage
		var ERRORSCREEN = load("res://Scenes/ErrorScreen/Error.tscn")
		if MusicController.playing == true:
			MusicController.Stop_music()
		get_tree().change_scene_to(ERRORSCREEN)
		var file = File.new()
		if file.file_exists(save_path):
			print("great!")
			var dat = loadjson()
			dat.Fun += 1
			savejson(data)
		else:
			createjson(data)
			var dat = loadjson()
			dat.Fun += 1
		if ErrorMessage == "FUN IS INFINITE FUN IS INFINITE FUN IS INFINITE":
				data.Fun = 666 # HE WHO IS HAS NOT
				# HE HAS DIED
				# THEY HAVE DIED
				# EVERYTHING IS DEAD
				# NOTHING IS REAL
	else:
		dialog.dialog_text = ErrorMessage + "\nPress OK To Ignore This\nPress Reload to Reload The Game"
		print(ErrorMessage)
		get_tree().paused = true
		dialog.window_title = "Oops!"
		if canvaslayer.get_child_count() == 0:
			canvaslayer.add_child(dialog)
		
		dialog.popup_centered()
		SoundController.Play_sound("Alert")
func savejson(da):
	var file = File.new()
	var error = file.open(save_path, File.WRITE)
	if error == OK:
		file.store_line(JSON.print(da))
		file.close()
		return da
func loadjson():
	var file = File.new()
	
	file.open(save_path, File.READ)
	var text = file.get_as_text()
	var dat = parse_json(text)
	data = dat
	file.close()
	return dat

func _what(what):
	canvaslayer.remove_child(dialog)
	get_tree().paused = false
	SceneLoader.ResetGame()
func _oof():
	canvaslayer.remove_child(dialog)
	get_tree().paused = false
func reset_done():
	var dat = loadjson()
	dat.Done = 0
	donealready = false
	savejson(data)
func up_done():
	data.Done += 1
	savejson(data)
