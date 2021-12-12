extends Node2D
class_name ChoiceMenu

signal option_selected(selected)

const FONT = preload("res://Assets/Fonts/font_alphabet.tres")

export var options = ["OPTION1", "OPTION2", "OPTION3"]
export var optionIcons = [] ## basically freeplay shit lol

export var iconSprs = {}

export var optionOffset = Vector2(20, 145)

export var enabled = true

var selected = 0
var optionsOffset = Vector2(0, 0)
var offset = Vector2.ZERO

func _process(_delta):
	update()
	
	if (enabled):
		move_option()
			
		if (Input.is_action_just_pressed("confirm")):
			emit_signal("option_selected", selected)
	
	offset = lerp(offset, Vector2.ZERO, 20 * _delta)
	optionsOffset = lerp(optionsOffset, optionOffset, 10 * _delta)
	
func _draw():
	draw_options()

func draw_options():
	var idx = 0
	
	for option in options:
		var sIdx = idx - selected
		
		var color = Color.darkgray
		
		if (selected == idx):
			color = Color.white
		
		if (!enabled):
			color = Color.webgray
			
		var textPos = position + Vector2((sIdx * optionsOffset.x) + 70, (sIdx * optionsOffset.y) + 320) + offset
		
		draw_string(FONT, textPos, option.to_upper(), color)
		
		if optionIcons.size() >= idx - 1:
			var iconTex = iconSprs[optionIcons[idx]]
			
			var frames = iconTex.get_width() / 150
			var xBackToGetToFirstFrame = 150 * (frames - 1)
			
			var rect = Rect2(Vector2(-1 * xBackToGetToFirstFrame,0), Vector2(iconTex.get_width(), iconTex.get_height()))
			
			var newPos = textPos - Vector2(xBackToGetToFirstFrame - 10, 25) + Vector2(FONT.get_string_size(option.to_upper()).x, 0)
			
			var coolRect = Rect2(newPos, Vector2(iconTex.get_width(), iconTex.get_height()))
			
			draw_texture_rect_region(iconTex, coolRect, rect)
		
		idx += 1

func move_option():
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
		SoundController.Play_sound("scrollMenu")
