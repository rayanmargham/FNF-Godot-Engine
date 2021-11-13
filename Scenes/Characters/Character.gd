tool
extends Node2D
class_name Character

export (bool) var flipX = false
export (Vector2) var spriteScale = Vector2(1, 1)
export (bool) var idleDance = false
export (bool) var idleDanceSpeed = false
export (Vector2) var camOffset = Vector2(0, 0)
export (bool) var girlfriendPosition = false

export (Resource) var iconSheet = preload("res://Assets/Stages/Characters/Icons/icon-face.png")
export (Color) var characterColor = Color.yellow

var lastIdleDance = null

func _ready():
	if Engine.editor_hint:
		return
	
	if !(idleDance):
		var _c_half_beat = MusicController.connect("half_beat_hit", self, "idle_dance")
	else:
		var _c_beat = MusicController.connect("beat_hit", self, "idle_dance")
		lastIdleDance = "danceLEFT"
		
	if (flipX):
		camOffset.x = -camOffset.x

func _process(_delta):
	if (flipX):
		scale = Vector2(-1 * spriteScale.x, spriteScale.y)
	else:
		scale = spriteScale
	
	if Engine.editor_hint:
		return

func play(animName):
	$AnimationPlayer.stop()
	if (flipX):
		match (animName):
			"singLEFT":
				animName = "singRIGHT"
			"singRIGHT":
				animName = "singLEFT"
			"singLEFTMiss":
				animName = "singRIGHTMiss"
			"singRIGHTMiss":
				animName = "singLEFTMiss"
	
	$AnimationPlayer.play(animName)
	
func idle_dance():
	if (get_idle_anim() == "idle"):
		if ($AnimationPlayer.assigned_animation == get_idle_anim()):
			$AnimationPlayer.stop()
			$AnimationPlayer.play(get_idle_anim())
	else:
		var bpmSpeed = 1
		if (idleDanceSpeed):
			bpmSpeed = (MusicController.bpm / 150)
		
		if (lastIdleDance == "danceLEFT"):
			$AnimationPlayer.play("danceRIGHT", -1, bpmSpeed)
		elif (lastIdleDance == "danceRIGHT"):
			$AnimationPlayer.play("danceLEFT", -1, bpmSpeed)
			
		lastIdleDance = $AnimationPlayer.assigned_animation
			
func _on_AnimationPlayer_animation_finished(anim_name):
	if (anim_name != get_idle_anim()):
		$AnimationPlayer.play(get_idle_anim(), -1, 1, true)

func get_idle_anim():
	if (idleDance):
		if ($AnimationPlayer.has_animation("danceLEFT")):
			return "danceLEFT"
	
	return "idle"
