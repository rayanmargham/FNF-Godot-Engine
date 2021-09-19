extends Node

onready var health = 1.00 setget set_health
onready var song_score = 0
signal up
signal down
signal left
signal right
onready var combo = 0
onready var note_ratings = {
	"sicks" : 0,
	"goods" : 0,
	"bads" : 0,
	"shits" : 0,
}

export var note_ms_timings = {
	"sick" : 45,
	"good" : 90,
	"bad" : 135,
	"shit" : 166
}

func _input(event):
	var note = ""
	if Input.is_action_just_pressed("note_up"): note = "up"
	elif Input.is_action_just_pressed("note_down"): note = "down"
	elif Input.is_action_just_pressed("note_left"): note = "left"
	elif Input.is_action_just_pressed("note_right"): note = "right"
	else: return
	
	# ======================================================
	# INSERT CODE TO CHECK FOR THE PROXIMITY OF NOTES ON THE SONG
	# ======================================================
	emit_signal(note)
	# This doesn't actually check for notes yet, it just returns "SICK!"
	
	var rating = _check_note_rating(0)
	increment_score(rating)
	if ["good", "sick"].has(rating): good_note_hit()
	print(rating)

# TODO: I have no idea what "ts" is, I believe it's related to replays
func _check_note_rating(ms, ts = 1):
	var timing = abs(ms) * ts
	if timing <= note_ms_timings.get("sick"): return "sick"
	elif timing <= note_ms_timings.get("good"): return "good"
	elif timing <= note_ms_timings.get("bad"): return "bad"
	elif timing <= note_ms_timings.get("shit"): return "shit"

# This could probably be optimized.
func increment_score(rating):
	match rating:
		"sick":
			health += 0.04
			song_score += 350
		"good":
			song_score += 200
		"bad":
			health -= 0.03
		"shit":
			health -= 0.06
			song_score -= 300

# THIS IS INCOMPLETE.
func good_note_hit():
	combo += 1

func set_health(new_value):
	health = clamp(0, new_value, 2)
