extends Node2D

# incase gf glitches for a sec set the max frames to 28
const MAX_GF_FRAMES = 29
# use this if you wanna have bf be in sync in the music with his animation speed (not very pog)
const MAX_BF_FRAMES = 13
onready var gf = $gf
onready var bf = $bf
func _ready():
	# sets gf's frame to 0 just incase
	gf.frame = 0
	#plays one of the test songs
	print("loaded stage")
	Mapper.loadmap("res://Assets/JSON&Text_Files/TestJson/tutorial-hard.json", false)
	var file = File.new()
	if file.file_exists(Mapper.json_path):
		var song = load("res://Assets/Songs/" + Mapper.json.song.song + "/" + "Inst.ogg")
		MusicController.play_song(song, Mapper.json.song.bpm)
	#curstep allows you to keep track of your position in the song which allows you to do cool things like change bpm in
	#a area of the song
func _process(delta):
	if MusicController.playing == true:
		# gf's frames are synced to the beat with the musiccontroller/conducter
		if gf.animation == "default":
			gf.frame = round(MusicController.get_beat_time() * MAX_GF_FRAMES)
		######--WARNING SHITTY CODE ALERT--######
		if round($"spotlight left".rotation_degrees) == -4:
			if $"spotlight left/Tween".is_active() == false:
				$"spotlight left/Tween".interpolate_property($"spotlight left", "rotation", deg2rad(-4), deg2rad(-26), 1.5, Tween.TRANS_QUAD, Tween.EASE_IN_OUT)
				$"spotlight left/Tween".start()
		elif round($"spotlight left".rotation_degrees) == -26:
			if $"spotlight left/Tween".is_active() == false:
				$"spotlight left/Tween".interpolate_property($"spotlight left", "rotation", deg2rad(-26), deg2rad(-4), 1.5, Tween.TRANS_QUAD, Tween.EASE_IN_OUT)
				$"spotlight left/Tween".start()
		if round($"spotlight right".rotation_degrees) == 26:
			if $"spotlight right/Tween".is_active() == false:
				$"spotlight right/Tween".interpolate_property($"spotlight right", "rotation", deg2rad(26), deg2rad(4), 1.5, Tween.TRANS_QUAD, Tween.EASE_IN_OUT)
				$"spotlight right/Tween".start()
		elif round($"spotlight right".rotation_degrees) == 4:
			if $"spotlight right/Tween".is_active() == false:
				$"spotlight right/Tween".interpolate_property($"spotlight right", "rotation", deg2rad(4), deg2rad(26), 1.5, Tween.TRANS_QUAD, Tween.EASE_IN_OUT)
				$"spotlight right/Tween".start()
		#print("GF's CURRENT FRAME" + str($gf.frame))
		#print("FRAME TIME:" + str(MusicController.GetBeatTime()))
		# example of what you can do with curstep
#		if MusicController.GetCurStep() == 5:
#			#lol its just changing the bpm 
#			# smoothly changes gf's frames
#			if $gf.frame == 0 or $gf.frame == 10:
#				MusicController.ChangeBPM(350)
	$DEBUG/Score.text = "Score: " + str($PlayerInput.song_score)
