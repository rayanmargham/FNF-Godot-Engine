tool
extends EditorPlugin

var plugin = preload("res://addons/Sprite_Font_Generator/InspectorPlugin.gd")

# make it when the project is open
func _enter_tree():
	plugin = plugin.new()
	add_inspector_plugin(plugin)

# delete it when its closed
func _exit_tree():
	remove_inspector_plugin(plugin)
