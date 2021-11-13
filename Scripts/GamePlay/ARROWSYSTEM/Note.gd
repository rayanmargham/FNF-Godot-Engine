extends Node2D

const SCROLL_DISTANCE = 1280 # units
var SCROLL_TIME = MusicController.SCROLL_TIME # sec

enum Note {Left, Down, Up, Right}

export (Note) var note_type = Note.Left

var strum_lane
var strum_time
var sustain_length
var must_hit = false

var missed = false
var playState

func _ready():
	var songSpeed = get_tree().current_scene.speed
	SCROLL_TIME = SCROLL_TIME / songSpeed
	
	playState = get_tree().current_scene
	
	if (visible):
		$Tween.interpolate_property(self, "position:y", SCROLL_DISTANCE * MusicController.scroll_speed, 0, SCROLL_TIME / MusicController.scroll_speed)
		$Tween.start()
	
func _on_Tween_tween_completed(_object, _key):
	if (strum_lane != null):
		if (missed):
			note_miss(true)
		
		if (!must_hit || Resources.botPlay):
			note_hit(0)
		else:
			missed = true
			$Tween.interpolate_property(self, "position:y", 0, -SCROLL_DISTANCE * MusicController.scroll_speed, SCROLL_TIME / MusicController.scroll_speed)
			$Tween.start()

func note_hit(timing):
	var animPlayer = strum_lane.get_node("AnimationPlayer")
	animPlayer.stop()
	animPlayer.play("hit")
	
	playState.on_hit(must_hit, note_type, timing)
	
	queue_free()
	
func note_miss(passed):
	playState.on_miss(must_hit, note_type, passed)
	print("miss lmao")
	queue_free()

func _process(_delta):
	if (missed && $Tween.tell() > 0.2):
		$Tween.remove_all()
		note_miss(true)
	
	if (Resources.downScroll):
		scale.y = -1
	
	$Sprite.frame = note_type * 2
