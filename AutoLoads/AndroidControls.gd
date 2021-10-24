extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var android_device = false

# Called when the node enters the scene tree for the first time.
func _ready():
	if OS.get_name() == "Android":
		android_device = true
		$CanvasLayer/Control.visible = true


func _on_Enter_button_down():
	if android_device:
		Input.action_press("ui_accept")

func _on_Enter_button_up():
	if android_device:
		Input.action_release("ui_accept")
