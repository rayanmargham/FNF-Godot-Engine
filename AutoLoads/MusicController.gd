#extends Node
#
#########################################
## This Autoload is for managing music
## and getting their BPM
#########################################
#
##===============Variables===========
#var FREAKY_BPM:int = 102
#var Freaky_BPS = 60.0/float(FREAKY_BPM)
# this code was written by me and it sucks
#var playing = false # keeps track of if a song is being played
#var curStep = 0 #Keeps track of the number of beats passed
#var halfCurStep = 0# more accurate
#var Beat_Time = 0 # Goes from 0 to 1, which is the length of a beat
#var Half_Beat_Time = 0 # Goes from 0 to 1, which is the length of half a beat
#var already_on_frame_beat = false
#var already_on_half_frame_beat = false
#
##===============Signals===========
#signal _on_one_Beat # Emitted on every beat
#signal _on_half_Beat # Emitted on every half beat (runs two times on every beat)
##warnings-disable
##===============Public Functions===========
#func Play_music(song = "freakyMenu", bpm = 102, position = 0, curstep = 0, halfcurstep = 0):
#	#Type the sound you want and it will search it for you
#
#	var target = null
#	match song:
#		"freakyMenu":
#			target = load("res://Assets/Menus/Music&Sounds/freakyMenu.ogg")
#			FREAKY_BPM = bpm
#			Freaky_BPS = 60.0/float(FREAKY_BPM)
#			curStep = 0
#			halfCurStep = 0
#			playing = true
#		"Pro":
#			target = load("res://Assets/Pro/Music&Sounds/KickBack.mp3")
#			FREAKY_BPM = bpm
#			Freaky_BPS = 60.0/float(FREAKY_BPM)
#			curStep = 0
#			halfCurStep = 0
#			playing = true
#		"Brushwhack":
#			target = load("res://Assets/TestSongs/Brushwhack/Inst.ogg")
#			FREAKY_BPM = bpm
#			Freaky_BPS = 60.0/float(FREAKY_BPM)
#			curStep = 0
#			halfCurStep = 0
#			playing = true
#		"ERROR":
#			target = load("res://Assets/Misc/ERROR/Audio/him.mp3")
#			FREAKY_BPM = bpm
#			Freaky_BPS = 60.0/float(FREAKY_BPM)
#			curStep = 0
#			halfCurStep = 0
#			playing = true
#		"Tutorial":
#			target = load("res://Assets/Songs/Tutorial/Tutorial_Inst.ogg")
#			FREAKY_BPM = bpm
#			Freaky_BPS = 60.0/float(FREAKY_BPM)
#			curStep = 0
#			halfCurStep = 0
#			playing = true
#		"SynthLoop2":
#			target = load("res://Assets/Menus/Music&Sounds/drumloop6.ogg")
#			FREAKY_BPM = bpm
#			Freaky_BPS = 60.0/float(FREAKY_BPM)
#			curStep = 0
#			halfCurStep = 0
#			playing = true
#		_:
#			playing = false
#			curStep = 0
#			halfCurStep = 0
#			print("ERROR: Could not play song: ", song)
#			ErrorManager.HandleError(false, "Could Not Play Song!")
#			return
#	$Music.stream = target
#	$Music.play()
#
#func Stop_music():
#	playing = false
#	$Music.stop()
#	curStep = 0
#	halfCurStep = 0
#func get_playback_position():
#	return $Music.get_playback_position()
#
## Getters
#func GetBeatTime():
#	return Beat_Time
#func GetHalfBeatTime():
#	return Half_Beat_Time
#
#func GetCurStep():
#	return curStep
#
#func ChangeBPM(bpm):
#	FREAKY_BPM = bpm
#	Freaky_BPS = 60.0/float(FREAKY_BPM)
#	return FREAKY_BPM
#func IsPlaying():
#	return playing
##===============Private Functions===========
#func _process(_delta):
#	# Get an accurate playback position of the song to stay on beat
#	var playback_pos = $Music.get_playback_position()
#	var time_since_last_mix = AudioServer.get_time_since_last_mix()
#	var latency = AudioServer.get_output_latency()
#	var time = playback_pos + time_since_last_mix - latency
#
#	# Turns the playback position into a lerpable value from 0 to 1 for a beat
#	Beat_Time = fmod((time+Freaky_BPS)/2, Freaky_BPS)/Freaky_BPS
#	Half_Beat_Time = fmod((time+Freaky_BPS)*1, Freaky_BPS)/Freaky_BPS
#
#	# Emit signal on every beat
#	if Beat_Time > 0.9 and already_on_frame_beat == false:
#		emit_signal("_on_one_Beat")
#		curStep += 1
#		already_on_frame_beat = true
#	if Beat_Time <= 0.9:
#		already_on_frame_beat = false
#
#	# Emit signal on every half beat
#	if Half_Beat_Time > 0.9 and already_on_half_frame_beat == false:
#		emit_signal("_on_half_Beat")
#		halfCurStep += 1
#		already_on_half_frame_beat = true
#	if Half_Beat_Time <= 0.9:
#		already_on_half_frame_beat = false
#
#
extends AudioStreamPlayer

signal quarter_hit(quarter)
signal eighth_hit(eighth)
signal sixteenth_hit(sixteenth)

enum Notes {QUARTER, EIGHTH, SIXTEENTH}
enum Directions {LEFT, DOWN, UP, RIGHT}

const SAFE_FRAMES = 10
# SAFE_ZONE: the amount of time (in seconds, assuming 60 FPS)
#			 before / after the note to be considered a valid hit.
const SAFE_ZONE = (SAFE_FRAMES / 60.0) * 1000 # safe frames in ms
# COUNTDOWN_CONSTANT: the # of beats before a level song plays
#						(for the 321GO! sequence).
const COUNTDOWN_CONSTANT = -4

onready var vocals = $Vocals
onready var countdown_timer = $Countdown_Timer
# code from fnf vr reewritten 
var bpm: float = 60
var beat_time = 0 # lerpable value
var half_beat_time = 0 # lerpable value for a half beat
var scroll_speed = 1
var debug_bpm = false
var crochet = ((60 / bpm) * 1000) # beats in ms
var stepCrochet = crochet / 4 # steps in ms

var song_position: float = 0 # in seconds
# time_begin: the exact timestamp (since engine launch / last pause in microseconds)
#			  that the current song started playing at.
var previous_frame_time: int = 0
var last_reported_playhead_position: float = 0
var counting_down = false

# Assigned -1 to include 1st beat of the song
var last_quarter   = -1
var last_eighth    = -1
var last_sixteenth = -1

# Last time (in seconds) the BPM changed
var last_bpm_change = 0
var last_quarter_before_change   = 0
var last_eighth_before_change    = 0
var last_sixteenth_before_change = 0

#### (Re-)Initialization #####################

var DEBUG = FpsCounter.debug

func _ready():
	$BPM_Debug.visible = debug_bpm
	set_process(false)
	# template for how a song must be loaded
	#var tut = load("res://Assets/Songs/Tutorial/Tutorial_Inst.ogg")
	#play_song(tut, 100)

func play_song(song, bpm_, vocals_ = null, scroll_speed_ = 1):
	if playing:
		stop_song()
	
	stream = song
	bpm = bpm_
	scroll_speed = scroll_speed_
	crochet = ((60 / bpm) * 1000)
	stepCrochet = crochet / 4
	
	if vocals:
		vocals.stream = vocals_
	vocals.volume_db = 0
	
	song_position = 0

	last_quarter   = -1
	last_eighth    = -1
	last_sixteenth = -1
	
	last_bpm_change = 0
	last_quarter_before_change   = 0
	last_eighth_before_change    = 0
	last_sixteenth_before_change = 0
	
	previous_frame_time = OS.get_ticks_usec()
	last_reported_playhead_position = 0
	
	play()
	if vocals_:
		vocals.play()
	
	if FpsCounter.debug and debug_bpm:
		$BPM_Debug/Label.text = str(bpm)
	
	set_process(true)

func play_song_with_countdown(song, bpm_, vocals_ = null, scroll_speed_ = 1):
	if playing:
		stop_song()
	
	bpm = bpm_
	
	last_quarter   = COUNTDOWN_CONSTANT - 1
	last_eighth    = COUNTDOWN_CONSTANT - 1
	last_sixteenth = COUNTDOWN_CONSTANT - 1
	
	countdown_timer.start(-COUNTDOWN_CONSTANT * get_seconds_per_beat())
	counting_down = true
	set_process(true)
	
	# Countdown should be handled by game
	var countdown_co = yield(self, "quarter_hit")
	
	while countdown_co < 0:
		countdown_co = yield(self, "quarter_hit")
	
	counting_down = false
	set_process(false)
	# TODO: fucking scroll speed brokey
#	play_song(song, bpm_, vocals_, scroll_speed_)
	play_song(song, bpm_, vocals_)

func stop_song():
	stop()
	vocals.stop()
	set_process(false)

#### Update Loop #####################

func _process(delta):
	update_time(delta)
	beat_time = fmod((song_position+get_seconds_per_beat())/2, get_seconds_per_beat())/get_seconds_per_beat()
	half_beat_time = fmod((song_position+get_seconds_per_beat()), get_seconds_per_beat())/get_seconds_per_beat()
	for note_name in ["quarter", "eighth", "sixteenth"]:
		var cur_beat = call("get_" + note_name, true)
		var last_beat = get("last_" + note_name)
		if cur_beat > last_beat:
			emit_signal(note_name + "_hit", cur_beat)
			set("last_" + note_name, cur_beat)
			
			if note_name == "quarter" && FpsCounter.debug && debug_bpm:
				print(cur_beat)
				$BPM_Debug/Tween.stop_all()
				$BPM_Debug/Tween.interpolate_property($BPM_Debug/Polygon2D, "scale",
													Vector2(70, 70), Vector2(60, 60), get_seconds_per_beat())
				$BPM_Debug/Tween.start()

# update_time: Gets precise playback position by obtaining the ticks since the engine started,
# compensates for audio latency and previous time when paused, and accounts for if the song hasn't
# started yet.
func update_time(delta):
	if counting_down:
		song_position = -countdown_timer.time_left
	else:
		song_position = max(0, song_position + (OS.get_ticks_usec() - previous_frame_time) / 1000000.0)
#		song_position += previous_frame_time - OS.get_ticks_usec() / 1000000.0
		previous_frame_time = OS.get_ticks_usec()
		
		if get_playback_position() != last_reported_playhead_position:
			song_position = (song_position + get_playback_position()) / 2.0
			last_reported_playhead_position = get_playback_position()
		
#		print("sp: " + str(song_position) + ", ph: " + str(get_playback_position()))
		#print(song_position)
#		song_position = max(0, ((OS.get_ticks_usec() - previous_frame_time) / 1000000.0) + song_pos_at_pause - (AudioServer.get_time_to_next_mix() + AudioServer.get_output_latency()))

#### Music Functions #################

func get_seconds_per_beat():
	return 60.0 / bpm

func get_beat(note, floored):
	var divisor = 1.0
	var last_beat_name = "quarter"
	
	match note:
		Notes.EIGHTH:
			divisor = 2.0
			last_beat_name = "eighth"
		Notes.SIXTEENTH:
			divisor = 4.0
			last_beat_name = "sixteenth"
	
	# Assumption: There are no BPM changes before the song starts
	# (why would you even do that? that sounds like a dumbass idea)
	if counting_down:
		if floored:
			return int(floor(song_position / (get_seconds_per_beat() / divisor)))
		return song_position / (get_seconds_per_beat() / divisor)
	
	var last_beat_before_change = get("last_" + last_beat_name + "_before_change")
	
	if floored:
		return last_beat_before_change + int(floor((song_position - last_bpm_change) / (get_seconds_per_beat() / divisor)))
	return last_beat_before_change + (song_position - last_bpm_change) / (get_seconds_per_beat() / divisor)

func is_beat(note, desired_beat):
	return get_beat(note, false) >= desired_beat

func get_quarter(floored):   return get_beat(Notes.QUARTER, floored)
func get_eighth(floored):    return get_beat(Notes.EIGHTH, floored)
func get_sixteenth(floored): return get_beat(Notes.SIXTEENTH, floored)

func is_quarter(desired_quarter):     return is_beat(Notes.QUARTER, desired_quarter)
func is_eighth(desired_eighth):       return is_beat(Notes.EIGHTH, desired_eighth)
func is_sixteenth(desired_sixteenth): return is_beat(Notes.SIXTEENTH, desired_sixteenth)

func get_quarter_length():   return get_seconds_per_beat()
func get_eighth_length():    return get_seconds_per_beat() / 2.0
func get_sixteenth_length(): return get_seconds_per_beat() / 4.0
func get_beat_time(): return beat_time
func get_half_beat_time(): return half_beat_time

#### Level Functions #################

func get_speed_difference(): return scroll_speed - 1.0
func get_actual_scroll_speed(): return 1.0 + get_speed_difference() / 2.0

# ASSUMPTION: BPM changes happen on quarters
# i don't even wanna think about if it doesn't
func change_bpm(bpm_):
	# The reason we set the last beat changes BEFORE the BPM change is
	# bc if we do it the other way around, the beat calculations get fucky wucky (scientific term)
	# (we'd be calculating the last beats with the current BPM, which is wrong)
	
	last_quarter_before_change = int(round(get_quarter(false)))
	last_eighth_before_change = int(round(get_eighth(false)))
	last_sixteenth_before_change = int(round(get_sixteenth(false)))
	
	last_bpm_change = song_position
	
	bpm = bpm_
	crochet = ((60 / bpm) * 1000)
	stepCrochet = crochet / 4
	
	if FpsCounter.debug && debug_bpm:
		$BPM_Debug/Label.text = str(bpm)
