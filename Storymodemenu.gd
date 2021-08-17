extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var weeknum = 0
var selected = false
var weeks = ["tutorial"]
var weeknames = [
	"tutorial"
]
var cry = 0
var diff = 1
var pushleft = preload("res://mainmenu/ui_assets/Kade Engine sussy stuff/arrow push left/arrow push left.png")
var pushright = preload("res://mainmenu/ui_assets/Kade Engine sussy stuff/arrow push right/arrow push right.png")
var left = preload("res://mainmenu/ui_assets/Kade Engine sussy stuff/arrow left/arrow left.png")
var right = preload("res://mainmenu/ui_assets/Kade Engine sussy stuff/arrow right/arrow right.png")
var tutorialselected0 = preload("res://mainmenu/ui_assets/Kade Engine sussy stuff/tutorialselect/tutorial selected0001.png")
var tutorialselected1 = preload("res://mainmenu/ui_assets/Kade Engine sussy stuff/tutorialselect/tutorial selected0002.png")
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		if selected == false:
			SoundController.play_sound("res://Menu Resources/cancelMenu.ogg", false)
			SceneLoader.Load("res://mainmenu.tscn")
	if event.is_action_pressed("ui_left"):
		if selected == false:
			
			$CanvasLayer/arrow_left.set_texture(pushleft)
			match diff:
				0:
					diff = 2
					$CanvasLayer/diff.set_diff("hard")
					
				1:
					$CanvasLayer/diff.set_diff("easy")
					diff -= 1
					
				2:
					$CanvasLayer/diff.set_diff("normal")
					diff -= 1
					
	if event.is_action_pressed("ui_right"):
		if selected == false:
			$CanvasLayer/arrow_right.set_texture(pushright)
			match diff:
					0:
						diff += 1
						$CanvasLayer/diff.set_diff("normal")
						
					1:
						$CanvasLayer/diff.set_diff("hard")
						diff += 1
						
					2:
						$CanvasLayer/diff.set_diff("easy")
						diff = 0
						
	if event.is_action_released("ui_left"):
		if selected == false:
			$CanvasLayer/arrow_left.set_texture(left)
	if event.is_action_released("ui_right"):
		if selected == false:
			$CanvasLayer/arrow_right.set_texture(right)
	if event.is_action_pressed("ui_up"):
		if selected == false:
			SoundController.play_sound("res://Menu Resources/scrollMenu.ogg", false)
			var sel = weeks.size()
			match sel:
				1:
					print("we on tutorial")
		else:
			pass
	if event.is_action_pressed("ui_down"):
		if selected == false:
			SoundController.play_sound("res://Menu Resources/scrollMenu.ogg", false)
			var sel = weeks.size()
			match sel:
				1:
					print("we on tutorial")
		else:
			pass
	if event.is_action_pressed("ui_accept"):
		if selected == false:
			SoundController.play_sound("res://Menu Resources/confirmMenu.ogg", false)
			selected = true
			match weeks[weeknum]:
				"tutorial":
					$CanvasLayer/VBoxContainer/Sprite/Timer.start()
					$CanvasLayer/bf_ui.animation = "hey"
					match diff:
						0:
							print("easy")
						1:
							print("normal")
						2:
							print("hard")
		else:
			pass
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Timer_timeout():
	match cry:
		0:
			$CanvasLayer/VBoxContainer/Sprite.set_texture(tutorialselected0)
		1:
			$CanvasLayer/VBoxContainer/Sprite.set_texture(tutorialselected1)
		2:
			$CanvasLayer/VBoxContainer/Sprite.set_texture(tutorialselected0)
		3:
			$CanvasLayer/VBoxContainer/Sprite.set_texture(tutorialselected1)
		4:
			$CanvasLayer/VBoxContainer/Sprite.set_texture(tutorialselected0)
		5:
			$CanvasLayer/VBoxContainer/Sprite.set_texture(tutorialselected1)
		6:
			$CanvasLayer/VBoxContainer/Sprite.set_texture(tutorialselected0)
		7:
			$CanvasLayer/VBoxContainer/Sprite.set_texture(tutorialselected1)
		8:
			$CanvasLayer/VBoxContainer/Sprite.set_texture(tutorialselected0)
		9:
			$CanvasLayer/VBoxContainer/Sprite.set_texture(tutorialselected1)
		10:
			$CanvasLayer/VBoxContainer/Sprite.set_texture(tutorialselected0)
			$CanvasLayer/VBoxContainer/Sprite/Timer.stop()
			MusicController.stop_music()
			SceneLoader.Load("res://Stages/Stage_tutorial.tscn")
	cry += 1
