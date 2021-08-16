extends Label

#==========================Variables==========================
# The random quotes
var Intro_Top_Quotes = ["KADE SMELLS", "STOP TROLLING", "UNITY MORE LIKE", "WE VIBING", "SUSSY", "AMOGUS IS", "BIG", "HELP", "I HAVE BRAIN DAMAGE", "HYPO", "GO PICO", "YOUR MUM", ":FLUSHED:"]
var Intro_Bottom_Quotes = [":TROLL:", "OR ELSE", "IDK", "NO AMONG US", "BAKA", "FUNNY!!", "ASS", "ME", "FROM YOU", "HYPO", "YEA YEA", "NOW LAUGH", ":FLUSHED:"]







var rng = RandomNumberGenerator.new()
signal why(value)

var what = 0
var p = JSON.parse('["KADE SMELLS", "STOP TROLLING", "UNITY MORE LIKE", "WE VIBING", "SUSSY", "AMOGUS IS", "BIG", "HELP", "I HAVE BRAIN DAMAGE", "HYPO", "GO PICO", "YOUR MUM", ":FLUSHED:"]')
var o = JSON.parse('[":TROLL:", "OR ELSE", "IDK", "NO AMONG US", "BAKA", "FUNNY!!", "ASS", "ME", "FROM YOU", "HYPO", "YEA YEA", "NOW LAUGH", ":FLUSHED:"]')
#var which = rng.randi_range(0, 10)

onready var timer = get_node("Timer")
func _ready():
	rng.randomize()
	MusicController.play_music("res://Menu Resources/intro.mp3", true)
	
	text = "CREATED BY"
	timer.start()
	var which = rng.randi_range(0, 11)
	rng.set_state(which)
	
func _input(event):
	if event.is_action_pressed("ui_accept"):
		get_tree().change_scene("res://menu.tscn")
		
func _on_Timer_timeout():
	what = what + 1
	#print(what)
	var result1 = p.result[rng.state]
	var result2 = o.result[rng.state]
	match what:
		
		25:
			text = ""
		30:
			text = "MADE USING"
		47:
			text = ""
		52:
			text = result1
		65:
			emit_signal("why", result2)
		70:
			text = ""
		75:
			text = "F"
		80:
			text = "FN"
		85:
			text = "FNF"
#		5.0:
#			text = "WEEBS BE LIKE"
#		7.0:
#			text = "FRIDAY"
#		7.5:
#			text = "FRIDAY NIGHT"
#		8.0:
#			text = "FRIDAY NIGHT FUNKIN"
#

