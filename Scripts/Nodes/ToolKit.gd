extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var isup = false
var command = ""
var password = "fard"
# warnings-disable
onready var animationplayer = $CanvasLayer/LineEdit/AnimationPlayer
onready var lineedit = $CanvasLayer/LineEdit
# Called when the node enters the scene tree for the first time.
func _ready():
	pass
func _input(event):
	if FpsCounter.debug == true:
		if event.is_action_pressed("DEBUG_KEY"):
			if isup == false:
				animationplayer.play("up")
				lineedit.grab_focus()
				isup = true
			elif isup == true:
				animationplayer.play("down")
				isup = false
func _process(delta):
	if command == "":
		match lineedit.text:
			"PRINT":
				lineedit.text = ""
				command = "PRINT"
				lineedit.placeholder_text = "PRINT WHAT?"
			"LOADPLAYSTATE":
				lineedit.text = ""
				command = "LOADPLAYSTATE"
				lineedit.placeholder_text = "Song,Difficulty (No Spaces)"
			"FUN IS INFINITE":
				command = "FUN"
				lineedit.text = ""
				lineedit.placeholder_text = "FUN FUN FUN FUN FUN FUN FUN FUN"
				ErrorManager.HandleError(true, "FUN IS INFINITE FUN IS INFINITE FUN IS INFINITE")
				animationplayer.play("down")
				isup = false
			"EXECUTE":
				command = "EXECUTE"
				lineedit.text = ""
				lineedit.placeholder_text = "EXECUTE WHAT?"
			"CONNECT TO WFC":
				command = "WFC"
				lineedit.text = ""
				lineedit.placeholder_text = "PASSWORD?"
func split(s: String, delimeters, allow_empty: bool = true) -> Array:
	var parts := []
	
	var start := 0
	var i := 0
	
	while i < s.length():
		if s[i] in delimeters:
			if allow_empty or start < i:
				parts.push_back(s.substr(start, i - start))
			start = i + 1
		i += 1
	
	if allow_empty or start < i:
		parts.push_back(s.substr(start, i - start))
	
	return parts

func _on_LineEdit_text_entered(new_text):
	match command:
		"LOADPLAYSTATE":
				SceneLoader.change_playstate(split(lineedit.text, ",", false)[0], split(lineedit.text, ",", false)[1])
				isup = false
				animationplayer.play("down")
				lineedit.placeholder_text = ""
				lineedit.text = ""
				command = ""
		"PRINT":
			print(lineedit.text)
			command = ""
			lineedit.placeholder_text = ""
			lineedit.text = ""
		"WFC":
			if lineedit.text == password:
				SceneLoader.Load("res://Scenes/Menus/Dev_Connection.tscn")
				isup = false
				animationplayer.play("down")
			else:
				lineedit.text = ""
				lineedit.placeholder_text = "INVAILD PASSWORD"
				yield(get_tree().create_timer(1), "timeout")
				command = ""
				lineedit.placeholder_text = ""
		"EXECUTE":
			var expression = Expression.new()
			var error = expression.parse(lineedit.text)
			if error != OK:
				lineedit.placeholder_text = expression.get_error_text()
				lineedit.text = ""
				yield(get_tree().create_timer(1), "timeout")
				lineedit.placeholder_text = ""
				command = ""
			var execute = expression.execute([], self)
			if expression.has_execute_failed():
				lineedit.placeholder_text = expression.get_error_text()
				lineedit.text = ""
				yield(get_tree().create_timer(1), "timeout")
				lineedit.placeholder_text = ""
				command = ""
			elif execute != null:
				if not execute is Object:
					lineedit.placeholder_text = str(execute)
					lineedit.text = ""
					yield(get_tree().create_timer(1), "timeout")
					lineedit.placeholder_text = ""
					command = ""
