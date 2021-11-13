extends EditorProperty
class_name SpriteFontGenCharWidthProp

var updating = false
var characterWidth = EditorSpinSlider.new()

func _init():
	label = "Character Width"
	add_child(characterWidth)
	
	characterWidth.connect("value_changed", self, "_width_changed")

func _width_changed(value):
	if (updating):
		return
	emit_changed(get_edited_property(), value)

func update_property():
	var new_value = get_edited_object()[get_edited_property()]
	updating = true
	characterWidth.set_value(new_value)
	updating = false
