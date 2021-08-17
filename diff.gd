extends Sprite


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var diff = 1
var normal = preload("res://mainmenu/ui_assets/Kade Engine sussy stuff/normal/NORMAL.png")
var hard = preload("res://mainmenu/ui_assets/Kade Engine sussy stuff/hard/HARD.png")
var easy = preload("res://mainmenu/ui_assets/Kade Engine sussy stuff/easy/EASY.png")
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
func set_diff(param1):
	var our = get_node("Tween")
	match param1:
		"easy":
			diff = 0
			set_texture(easy)
			our.interpolate_property(self, "position", Vector2(852.909, 403), Vector2(852.909, 420)	, 0.07, Tween.TRANS_LINEAR, Tween.EASE_IN)
			our.start()
		"hard":
			diff = 2
			set_texture(hard)
			our.interpolate_property(self, "position", Vector2(852.909, 403), Vector2(852.909, 420)	, 0.07, Tween.TRANS_LINEAR, Tween.EASE_IN)
			our.start()
		"normal":
			diff = 1
			set_texture(normal)
			our.interpolate_property(self, "position", Vector2(852.909, 403), Vector2(852.909, 420)	, 0.07, Tween.TRANS_LINEAR, Tween.EASE_IN)
			our.start()
func get_diff():
	return diff

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
