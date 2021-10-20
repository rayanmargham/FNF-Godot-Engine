extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var h = false
onready var BG = $CanvasLayer/BG
# Called when the node enters the scene tree for the first time.
func _ready():
	FpsCounter.pause_mode = FpsCounter.PAUSE_MODE_PROCESS
func _input(event):
	if event.is_action_pressed("ui_accept") and SceneLoader.isweek == true:
		if h == false:
			h = true
			get_tree().paused = true
			BG.visible = true
			print("paused")
			$AudioStreamPlayer.play()
		else:
			h = false
			BG.visible = false
			$AudioStreamPlayer.stop()
			get_tree().paused = false
		
