extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var network = NetworkedMultiplayerENet.new()
var ip = "192.168.68.100"
var port = 1909
signal connected
signal failed
var connected = false
#warnings-disable
# Called when the node enters the scene tree for the first time.
func Connect_To_WFC(devmode = false):
	network.create_client(ip, port)
	get_tree().set_network_peer(network)
	network.connect("connection_succeeded", self, "_connected")
	network.connect("connection_failed", self, "_failed_to_connect")
func Disconnect_From_WFC():
	network.close_connection()
	network.disconnect("connection_succeeded", self, "_connected")
	network.disconnect("connection_failed", self, "_failed_to_connect")
	connected = false
func _failed_to_connect():
	emit_signal("failed")
	connected = false
func _connected():
	emit_signal("connected")
	connected = true
