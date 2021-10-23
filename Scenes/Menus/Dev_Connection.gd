extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
#warnings-disable

# Called when the node enters the scene tree for the first time.
func _ready():
	FpsCounter.HideCounter()
	var brush = load("res://Assets/TestSongs/Brushwhack/Inst.ogg")
	MusicController.play_song(brush, 198)
	WFC.Connect_To_WFC(true)
	WFC.connect("connected", self, "connected_to_server")
	WFC.connect("failed", self, "failed_to_connect")
func connected_to_server():
	$Connection/FG/RichTextLabel.text = "Dev Mode Funkin' WFC\n     CONNECTED"

func failed_to_connect():
	$Connection/FG/RichTextLabel.text = "Dev Mode Funkin' WFC\n       FAILED"
func _on_Control_tree_exiting():
	WFC.Disconnect_From_WFC()
