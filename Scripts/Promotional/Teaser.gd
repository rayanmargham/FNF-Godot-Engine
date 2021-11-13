extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
func _ready():
	FpsCounter.HideCounter()
	yield(get_tree().create_timer(1), "timeout")
	$AnimationPlayer.play("Trailer")
