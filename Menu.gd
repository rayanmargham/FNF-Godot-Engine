extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var i = 0
onready var timer = get_node("ColorRect/Timer")
# Called when the node enters the scene tree for the first time.
func _ready():
	timer.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_Timer_timeout():
	get_node("ColorRect").modulate.a -= 0.01 # Replace with function body.
