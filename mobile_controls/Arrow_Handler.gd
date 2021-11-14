extends CanvasLayer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	if OS.get_name() == "Android":
		OS.request_permissions()
		for i in get_children():
			if i.name in ["left", "down", "up", "right"]:
				i.visible = true
				i.connect("pressed", self, "_pressed")
func _pressed():
	$AnimationPlayer.stop(true)
	$AnimationPlayer.play("hit")
