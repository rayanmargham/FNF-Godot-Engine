extends Tween


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var high = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func _process(delta):
	if high == false:
		if !is_active():
			interpolate_property(get_parent(), "position:y", get_parent().position.y, get_parent().position.y + -100, 1.5, Tween.TRANS_QUAD, Tween.EASE_IN_OUT)
			start()
			yield(self, "tween_completed")
			high = true
	else:
		if !is_active():
				interpolate_property(get_parent(), "position:y", get_parent().position.y, get_parent().position.y - -100, 1.5, Tween.TRANS_QUAD, Tween.EASE_IN_OUT)
				start()
				yield(self, "tween_completed")
				high = false
