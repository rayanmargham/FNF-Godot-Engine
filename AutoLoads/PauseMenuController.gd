extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var h = false
onready var BG = $CanvasLayer/BG
onready var Inital_MenuItems_Container_Position = $CanvasLayer/BG/VBoxContainer.rect_position
enum menuitems {
	CONTINUE,
	RESTART,
	BACKTOMENU
}
var disabled = false
var selected_menu_item = menuitems.CONTINUE
# Called when the node enters the scene tree for the first time.
func _ready():
	FpsCounter.pause_mode = FpsCounter.PAUSE_MODE_PROCESS
func _input(event):
		if SceneLoader.isweek == true and disabled == false:
			if event.is_action_pressed("ui_accept"):
				if h == false:
					h = true
					get_tree().paused = true
					BG.visible = true
					$AudioStreamPlayer.play()
				else:
					match selected_menu_item:
						menuitems.CONTINUE:
							h = false
							BG.visible = false
							$AudioStreamPlayer.stop()
							get_tree().paused = false
						menuitems.BACKTOMENU:
							h = false
							BG.visible = false
							$AudioStreamPlayer.stop()
							get_tree().paused = false
							MusicController.stop_song()
							SceneLoader.Load("res://Scenes/Menus/StoryModeMenu.tscn")
						menuitems.RESTART:
							$fard.play()
			if event.is_action_pressed("ui_down") and h == true:
				SoundController.Play_sound("scrollMenu")
				selected_menu_item = posmod(selected_menu_item+1, 3)
			if event.is_action_pressed("ui_up") and h == true:
				SoundController.Play_sound("scrollMenu")
				selected_menu_item = posmod(selected_menu_item-1, 3)
			
func _process(_delta):
	for i in $CanvasLayer/BG/VBoxContainer.get_child_count():
		if i == selected_menu_item:
			$CanvasLayer/BG/VBoxContainer.get_child(i).modulate.a = 1
		else:
			$CanvasLayer/BG/VBoxContainer.get_child(i).modulate.a = 0.5
	$CanvasLayer/BG/VBoxContainer.rect_position.y = lerp($CanvasLayer/BG/VBoxContainer.rect_position.y, Inital_MenuItems_Container_Position.y-selected_menu_item*37, 0.2)
