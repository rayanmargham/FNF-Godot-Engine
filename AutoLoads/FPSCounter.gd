extends Node

# Timestamps of frames rendered in the last second
var times := []

# Frames per second
var fps := 0
# DEBUG VAR THAT CAN BE ACCESSED FROM EVERYWHERE
var debug = true

func _process(_delta: float) -> void:
	var now := OS.get_ticks_msec()

	# Remove frames older than 1 second in the `times` array
	while times.size() > 0 and times[0] <= now - 1000:
		times.pop_front()

	times.append(now)
	fps = times.size()

	# Display FPS in the label
	$CanvasLayer/RichTextLabel.bbcode_text = "FPS: " + str(fps)

func HideCounter():
	if $CanvasLayer/Tween.is_active() == false:
		$CanvasLayer/Tween.interpolate_property($CanvasLayer/RichTextLabel, "modulate:a", 1, 0, 0.3, Tween.TRANS_QUAD, Tween.EASE_IN)
		$CanvasLayer/Tween.start()
	else:
		$CanvasLayer/RichTextLabel.modulate.a = 0
func ShowCounter():
	if $CanvasLayer/Tween.is_active() == false:
		$CanvasLayer/Tween.interpolate_property($CanvasLayer/RichTextLabel, "modulate:a", 0, 1, 0.3, Tween.TRANS_QUAD, Tween.EASE_IN)
		$CanvasLayer/Tween.start()
	else:
		$CanvasLayer/RichTextLabel.modulate.a = 1
