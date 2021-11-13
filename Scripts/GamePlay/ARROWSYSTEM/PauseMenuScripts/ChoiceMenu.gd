extends Node2D
class_name ChoiceMenu

signal option_selected(selected)

const FONT = preload("res://Assets/Fonts/font_alphabet.tres")

export var options = ["OPTION1", "OPTION2", "OPTION3"]
export var optionOffset = Vector2(20, 145)

export var enabled = true

onready var moveStream = AudioStreamPlayer.new()

var selected = 0
var optionsOffset = Vector2(0, 0)
var offset = Vector2.ZERO

func _ready():
	add_child(moveStream)
	SoundController.Play_sound("scrollMenu")

func _process(_delta):
	update()
	
	if (enabled):
		var move = int(Input.is_action_just_pressed("down")) - int(Input.is_action_just_pressed("up"))
		selected += move
		
		if (selected > options.size() - 1):
			selected = 0
			move = -move
		elif (selected < 0):
			selected = options.size() - 1
			move = -move
			
		if (move != 0):
			offset = Vector2(optionsOffset.x * move, optionsOffset.y * move)
			moveStream.play()
			
		if (Input.is_action_just_pressed("confirm")):
			emit_signal("option_selected", selected)
	
	offset = lerp(offset, Vector2.ZERO, 0.2)
	optionsOffset = lerp(optionsOffset, optionOffset, 0.1)
	
func _draw():
	var idx = 0
	for option in options:
		var sIdx = idx - selected
		
		var color = Color.darkgray
		if (selected == idx):
			color = Color.white
		if (!enabled):
			color = Color.webgray
		
		draw_string(FONT, position + Vector2((sIdx * optionsOffset.x) + 70, (sIdx * optionsOffset.y) + 320) + offset, option.to_upper(), color)
		idx += 1
