extends Node

onready var player_health = 1.00
onready var song_score = 0
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

func _ready():
	note_ratings.goods += 1
	print(note_ratings)
	print(_check_note_rating(-100))

# TODO: I have no idea what "ts" is, I believe it's related to replays
func _check_note_rating(ms, ts = 1):
	var timing = abs(ms) * ts
	if timing <= note_ms_timings.get("sick"): return "sick"
	elif timing <= note_ms_timings.get("good"): return "good"
	elif timing <= note_ms_timings.get("bad"): return "bad"
	elif timing <= note_ms_timings.get("shit"): return "shit"

func increment_score():
	pass
