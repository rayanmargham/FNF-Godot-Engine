extends EditorProperty
class_name SpriteFontGenButtonProp

var button = Button.new()

const FONT_STRING = "ABCDEFGHIJKLMNOPQRSTUVWXYZ, 0123456789-.:@_"

func _init():
	button.text = "Generate"
	add_child(button)
	
	button.connect("pressed", self, "_generate_pressed")

func _generate_pressed():
	print(FONT_STRING)
	
	# ord_at
	var bitmapFont = get_edited_object()
	bitmapFont.add_texture(preload("res://Assets/Fonts/alphabet.png"))
	bitmapFont.height = 87
	
	# loop through each character and add it
	for i in FONT_STRING.length():
		var character = FONT_STRING.ord_at(i)
		bitmapFont.add_char(character, 0, Rect2(i*87, 0, 87, 87), Vector2(0, 0), 50)
		
	var resourcePath = get_edited_object().get_path()
	if (ResourceSaver.save(resourcePath, bitmapFont) == OK):
		emit_changed("height", bitmapFont)
