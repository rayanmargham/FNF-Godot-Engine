extends Node2D

# incase gf glitches for a sec set the max frames to 28
const MAX_GF_FRAMES = 29
# use this if you wanna have bf be in sync in the music with his animation speed (not very pog)
const MAX_BF_FRAMES = 13
func _ready():
	# sets gf's frame to 0 just incase
	$gf.frame = 0
	#plays one of the test songs
	MusicController.Play_music("Brushwhack", 215)
	#curstep allows you to keep track of your position in the song which allows you to do cool things like change bpm in
	#a area of the song
func _process(delta):
	if MusicController.IsPlaying() == true:
		# gf's frames are synced to the beat with the musiccontroller/conducter
		$gf.frame = round(MusicController.GetBeatTime() * MAX_GF_FRAMES)
		#print("GF's CURRENT FRAME" + str($gf.frame))
		#print("FRAME TIME:" + str(MusicController.GetBeatTime()))
		# example of what you can do with curstep
#		if MusicController.GetCurStep() == 5:
#			#lol its just changing the bpm 
#			# smoothly changes gf's frames
#			if $gf.frame == 0 or $gf.frame == 10:
#				MusicController.ChangeBPM(350)
	if FpsCounter.debug == true:
		#for debug purposes
		$DEBUG/Frame.text = "FRAME TIME: " + str(MusicController.GetBeatTime())
		$DEBUG/GFCURRENT.text = "GF's CURRENT FRAME: " + str($gf.frame)
		$DEBUG/Score.text = "Score: " + str($PlayerInput.song_score)
	else:
		#resets text
		$DEBUG/Frame.text = ""
		$DEBUG/GFCURRENT.text = ""
