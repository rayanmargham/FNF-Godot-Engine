extends Node


var json_path = null
var json = {}
func loadmap(jsontoload = "", giveback = false):
	json_path = jsontoload
	var file = File.new()
	if not file.file_exists(json_path):
		ErrorManager.HandleError(false, "Failed To Load JSON")
		return
	file.open(json_path, File.READ)
	var data = parse_json(file.get_as_text())
	json = data
	if giveback == true:
		return data
	
