extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var drums_player = AudioStreamPlayer.new()
var chords_player = AudioStreamPlayer.new()
var bass_player = AudioStreamPlayer.new()
var freaky_player = AudioStreamPlayer.new()
var aye_player = AudioStreamPlayer.new()
var man_player = AudioStreamPlayer.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	add_child(drums_player)
	add_child(chords_player)
	add_child(bass_player)
	add_child(freaky_player)
	add_child(aye_player)
	add_child(man_player)
	drums_player.stream = load("res://Assets/Menus/Music&Sounds/strums/drums.wav")
	chords_player.stream = load("res://Assets/Menus/Music&Sounds/strums/chords.wav")
	bass_player.stream = load("res://Assets/Menus/Music&Sounds/strums/bass.wav")
	freaky_player.stream = load("res://Assets/Menus/Music&Sounds/strums/gettin_freaky.wav")
	aye_player.stream = load("res://Assets/Menus/Music&Sounds/strums/warped_aye.wav")
	man_player.stream = load("res://Assets/Menus/Music&Sounds/strums/go_man_go.wav")
	chords_player.play(19)
	bass_player.play(19)
