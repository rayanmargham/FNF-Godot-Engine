extends Node2D

# ASSUMPTIONS:
# - Sheet and image have the same path
# - Sheet is an Adobe Animate XML and image is a PNG
export(String) var load_path = "res://"
export(String) var save_path = "res://"
export(bool) var optimize = false

onready var anim_sprite = $AnimatedSprite

func _ready():
	set_process(false)
	yield(get_tree(), "idle_frame")
	
	var xml_parser = XMLParser.new()
	xml_parser.open(load_path + ".xml")
	
	var frames = anim_sprite.frames
	var texture = load(load_path + ".png")
	var cur_anim_name
	
	print(ResourceSaver.get_recognized_extensions(frames))
	
	var err = xml_parser.read()
	while err == OK:
		if xml_parser.get_node_type() == XMLParser.NODE_ELEMENT || xml_parser.get_node_type() == XMLParser.NODE_ELEMENT_END:
			print("--- " + xml_parser.get_node_name() + " ---")
			
			if xml_parser.get_node_name() != "TextureAtlas":
				var loaded_anim_name: String = xml_parser.get_named_attribute_value("name")
				loaded_anim_name = loaded_anim_name.left(len(loaded_anim_name) - 4)
				print("loaded name: " + loaded_anim_name)
				
				if cur_anim_name != loaded_anim_name:
					frames.add_animation(loaded_anim_name)
					frames.set_animation_loop(loaded_anim_name, false)
					frames.set_animation_speed(loaded_anim_name, 24)
					cur_anim_name = loaded_anim_name
				
				var new_region = Rect2(int(xml_parser.get_named_attribute_value("x")), int(xml_parser.get_named_attribute_value("y")),
									   int(xml_parser.get_named_attribute_value("width")), int(xml_parser.get_named_attribute_value("height")))
				var new_margin = Rect2()
				if xml_parser.has_attribute("frameX"):
					new_margin = Rect2(-int(xml_parser.get_named_attribute_value("frameX")), -int(xml_parser.get_named_attribute_value("frameY")),
										int(xml_parser.get_named_attribute_value("frameWidth")) - new_region.size.x, int(xml_parser.get_named_attribute_value("frameHeight")) - new_region.size.y)
				
				var num_frames = frames.get_frame_count(cur_anim_name)
				var prev_frame = frames.get_frame(cur_anim_name, num_frames - 1) if num_frames > 0 else null
				
				if optimize && prev_frame && new_region == prev_frame.region && new_margin == prev_frame.margin:
					print("optimizing " + str(num_frames))
					frames.add_frame(cur_anim_name, prev_frame)
				else:
					var new_frame = AtlasTexture.new()
					new_frame.atlas = texture
					new_frame.region = new_region
					new_frame.margin = new_margin
					new_frame.flags = Texture.FLAG_MIPMAPS
					new_frame.filter_clip = true
					
					frames.add_frame(cur_anim_name, new_frame)
		
		yield(get_tree().create_timer(0.01), "timeout")
		err = xml_parser.read()
	
	print("done")
	
	frames.remove_animation("default")
	ResourceSaver.save(save_path + ".res", frames, ResourceSaver.FLAG_COMPRESS)
	
	print("saved, restart the project to unfuck up the sheet")
