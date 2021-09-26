extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var s = false
var g = 0
var a = ["OH HELLO", "HI", "WELCOME TO THE SHOW", "DID YOU HEAR ABOUT IT", "SOMEONES REMAKING FNF IN GODOT", "APPARENTLY", "A REMAKE SO GOOD", "IT RUNS ON A CORE 2 DUO", "IT RUNS ON A CORE 13", "IT RUNS ON A CORE 15", "IT RUNS ON A CORE 17", "IT RUNS A TOASTER", "IT RUNS ON A POTATO"]
# Called when the node enters the scene tree for the first time.
func _ready():
	FpsCounter.HideCounter()
	yield(get_tree().create_timer(5), "timeout")
	MusicController.connect("_on_half_Beat", self, "_sussy")
	MusicController.Play_music("Pro", 158)
func _sussy():
	if g >= a.size():
		return
	$Label.text = a[g]
	if a[g] == "SOON":
		$AnimationPlayer.play("flash")
	g += 1
func _process(delta):
	if MusicController.halfCurStep == 15:
		$Label.text = "NO JOKE"
	if MusicController.halfCurStep == 30 or MusicController.halfCurStep == 31:
		$Camera2D.zoom -= Vector2(0.01, 0.01)
		$Label.text = "YOOO"
	if MusicController.halfCurStep == 32:
		$Camera2D.zoom = Vector2(1, 1)
		$Label.text = ""
	if abs(MusicController.get_playback_position() - 6) < 0.1 and s == false:
		s = true
		g = 0
		a = ["SO GOOD", "IT EVEN HAS A ONLINE FEATURE", "WAIT FR?", "FR", "WHY SHOULD I CARE THO", "WHY SHOULD 1 CARE TH0", "ITS EASIER FOR MODDING", "ITS EAS1ER F0R M0DDING" ,"YOO WHEN WILL IT COME OUT", "YOO WH4N W1LL 1T C0ME OUT","SOON"]
