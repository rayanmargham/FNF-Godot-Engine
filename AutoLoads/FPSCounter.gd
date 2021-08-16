extends RichTextLabel

# Timestamps of frames rendered in the last second
var times := []

# Frames per second
var fps := 0


func _process(_delta: float) -> void:
	var now := OS.get_ticks_msec()

	# Remove frames older than 1 second in the `times` array
	while times.size() > 0 and times[0] <= now - 1000:
		times.pop_front()

	times.append(now)
	fps = times.size()

	# Display FPS in the label
	bbcode_text = "FPS: " + str(fps)
