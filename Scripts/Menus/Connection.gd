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
	FpsCounter.HideCounter()
	WFC.Connect_To_WFC(false)
	WFC.connect("connected", self, "connected_to_server")
	WFC.connect("failed", self, "failed_to_connect")
func connected_to_server():
	yield(get_tree().create_timer(2), "timeout")
	chords_player.stop()
	bass_player.stop()
	$Connection/RichTextLabel.bbcode_text = "[center]CONNECTED"
	$Connection/RichTextLabel/AnimationPlayer.play("Connected")
	$"3D/Camera/AnimationPlayer".play("Whoosh")

func failed_to_connect():
	yield(get_tree().create_timer(1), "timeout")
	$Connection/RichTextLabel.bbcode_text = "[center]FAILED"
func _on_Control_tree_exiting():
	WFC.Disconnect_From_WFC()


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "Whoosh":
		print("Going to: WFC Menu 1")
		get_tree().change_scene_to(preload("res://Scenes/Menus/WFCMenu1.tscn"))
