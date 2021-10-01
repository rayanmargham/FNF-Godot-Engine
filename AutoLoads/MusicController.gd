extends Node

########################################
# This Autoload is for managing music
# and getting their BPM
########################################

#===============Variables===========
var FREAKY_BPM:int = 102
var Freaky_BPS = 60.0/float(FREAKY_BPM)

var playing = false # keeps track of if a song is being played
var curStep = 0 #Keeps track of the number of beats passed
var halfCurStep = 0# more accurate
var Beat_Time = 0 # Goes from 0 to 1, which is the length of a beat
var Half_Beat_Time = 0 # Goes from 0 to 1, which is the length of half a beat
var already_on_frame_beat = false
var already_on_half_frame_beat = false

#===============Signals===========
signal _on_one_Beat # Emitted on every beat
signal _on_half_Beat # Emitted on every half beat (runs two times on every beat)

#===============Public Functions===========
func Play_music(song = "freakyMenu", bpm = 102):
	#Type the sound you want and it will search it for you
	
	var target = null
	match song:
		"freakyMenu":
			target = load("res://Assets/Menus/Music&Sounds/freakyMenu.ogg")
			FREAKY_BPM = bpm
			Freaky_BPS = 60.0/float(FREAKY_BPM)
			curStep = 0
			halfCurStep = 0
			playing = true
		"Pro":
			target = load("res://Assets/Pro/Music&Sounds/KickBack.mp3")
			FREAKY_BPM = bpm
			Freaky_BPS = 60.0/float(FREAKY_BPM)
			curStep = 0
			halfCurStep = 0
			playing = true
		"Brushwhack":
			target = load("res://Assets/TestSongs/Brushwhack/Inst.ogg")
			FREAKY_BPM = bpm
			Freaky_BPS = 60.0/float(FREAKY_BPM)
			curStep = 0
			halfCurStep = 0
			playing = true
		"ERROR":
			target = load("res://Assets/Misc/ERROR/Audio/him.mp3")
			FREAKY_BPM = bpm
			Freaky_BPS = 60.0/float(FREAKY_BPM)
			curStep = 0
			halfCurStep = 0
			playing = true
		"Tutorial":
			target = load("res://Assets/Songs/Tutorial/Tutorial_Inst.ogg")
			FREAKY_BPM = bpm
			Freaky_BPS = 60.0/float(FREAKY_BPM)
			curStep = 0
			halfCurStep = 0
			playing = true
		"Before The Story":
			target = load("res://Misc/FirstUse/Music/toby.wav")
			FREAKY_BPM = bpm
			Freaky_BPS = 60.0/float(FREAKY_BPM)
			curStep = 0
			halfCurStep = 0
			playing = true
		_:
			playing = false
			curStep = 0
			halfCurStep = 0
			print("ERROR: Could not play song: ", song)
			ErrorManager.HandleError(false, "Could Not Play Song!")
			return
	$Music.stream = target
	$Music.play()
	
func Stop_music():
	playing = false
	$Music.stop()
	curStep = 0
	halfCurStep = 0
func get_playback_position():
	return $Music.get_playback_position()

# Getters
func GetBeatTime():
	return Beat_Time
func GetHalfBeatTime():
	return Half_Beat_Time

func GetCurStep():
	return curStep

func ChangeBPM(bpm):
	FREAKY_BPM = bpm
	Freaky_BPS = 60.0/float(FREAKY_BPM)
	return FREAKY_BPM
func IsPlaying():
	return playing
#===============Private Functions===========
func _process(_delta):
	# Get an accurate playback position of the song to stay on beat
	var playback_pos = $Music.get_playback_position()
	var time_since_last_mix = AudioServer.get_time_since_last_mix()
	var latency = AudioServer.get_output_latency()
	var time = playback_pos + time_since_last_mix - latency
	
	# Turns the playback position into a lerpable value from 0 to 1 for a beat
	Beat_Time = fmod((time+Freaky_BPS)/2, Freaky_BPS)/Freaky_BPS
	Half_Beat_Time = fmod((time+Freaky_BPS)*1, Freaky_BPS)/Freaky_BPS
	
	# Emit signal on every beat
	if Beat_Time > 0.9 and already_on_frame_beat == false:
		emit_signal("_on_one_Beat")
		curStep += 1
		already_on_frame_beat = true
	if Beat_Time <= 0.9:
		already_on_frame_beat = false
	
	# Emit signal on every half beat
	if Half_Beat_Time > 0.9 and already_on_half_frame_beat == false:
		emit_signal("_on_half_Beat")
		halfCurStep += 1
		already_on_half_frame_beat = true
	if Half_Beat_Time <= 0.9:
		already_on_half_frame_beat = false


