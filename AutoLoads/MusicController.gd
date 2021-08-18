extends Node

########################################
# This Autoload is for managing music
# and getting their BPM
########################################

#===============Variables===========
const FREAKY_BPM = 102
var Freaky_BPS = 60.0/102.0

var Beat_Time = 0 # Goes from 0 to 1, which is the length of a beat
var Half_Beat_Time = 0 # Goes from 0 to 1, which is the length of half a beat
var already_on_frame_beat = false
var already_on_half_frame_beat = false

#===============Signals===========
signal _on_one_Beat # Emitted on every beat
signal _on_half_Beat # Emitted on every half beat (runs two times on every beat)

#===============Public Functions===========
func Play_music(song = "freakyMenu"):
	#Type the sound you want and it will search it for you
	
	var target = null
	match song:
		"freakyMenu":
			target = load("res://Assets/Menus/Music&Sounds/freakyMenu.ogg")
		_:
			print("ERROR: Could not play song: ", song)
			return
	$Music.stream = target
	$Music.play()
	
func Stop_music():
	$Music.stop()
func get_playback_position():
	return $Music.get_playback_position()

# Getters
func GetBeatTime():
	return Beat_Time
func GetHalfBeatTime():
	return Half_Beat_Time
	
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
		already_on_frame_beat = true
	if Beat_Time <= 0.9:
		already_on_frame_beat = false
	
	# Emit signal on every half beat
	if Half_Beat_Time > 0.9 and already_on_half_frame_beat == false:
		emit_signal("_on_half_Beat")
		already_on_half_frame_beat = true
	if Half_Beat_Time <= 0.9:
		already_on_half_frame_beat = false


