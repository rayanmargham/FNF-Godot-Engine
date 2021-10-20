extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var isup = false
var command = ""
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
			"LOADWEEK":
				lineedit.text = ""
				command = "SCENE"
				lineedit.placeholder_text = "SCENE TO LOAD?"
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


func _on_LineEdit_text_entered(new_text):
	match command:
		"SCENE":
			match lineedit.text:
				"WEEK0":
					SceneLoader.Load_Week(lineedit.text, "normal", true)
					isup = false
					animationplayer.play("down")
					lineedit.placeholder_text = "LOADED SCENE"
					lineedit.text = ""
					yield(get_tree().create_timer(1), "timeout")
					lineedit.placeholder_text = ""
					command = ""
			if SceneLoader.failed == true:
				print("FAILED")
				lineedit.placeholder_text = "FAILED TO LOAD THAT SCENE"
				lineedit.text = ""
				yield(get_tree().create_timer(1), "timeout")
				lineedit.placeholder_text = ""
				command = ""
		"PRINT":
			print(lineedit.text)
			command = ""
			lineedit.placeholder_text = ""
			lineedit.text = ""
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
