extends EditorInspectorPlugin

# called when a object is selected
func can_handle(object):
	return object is BitmapFont
	
func parse_end():
	var label = Label.new()
	label.text = "Generate Sprite Font"
	
	add_custom_control(label)
	add_property_editor("button", SpriteFontGenButtonProp.new())

