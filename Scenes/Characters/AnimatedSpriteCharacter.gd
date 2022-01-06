tool
extends Node2D
class_name Animated_Character

export (bool) var flipX = false
export (Vector2) var spriteScale = Vector2(1, 1)
export (bool) var idleDance = false
export (bool) var idleDanceSpeed = false
export (Vector2) var camOffset = Vector2(0, 0)
export (bool) var girlfriendPosition = false
export (Resource) var iconSheet = preload("res://Assets/Stages/Characters/Icons/icon-face.png")
export (Color) var characterColor = Color.yellow

var lastIdleDance = null
var idleTimer = 0
var MAXFRAMES = 0

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
	if idleTimer > 0:
		idleTimer -= 1 * _delta

func play(animName):
	$AnimatedSprite.stop()
	$AnimatedSprite.frame = 0
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
	$AnimatedSprite.play(animName)
	
func idle_dance():
	if (get_idle_anim() == "idle"):
		if (idleTimer <= 0):
			$AnimatedSprite.stop()
			$AnimatedSprite.frame = 0
			$AnimatedSprite.play(get_idle_anim())
	else:
		if (idleTimer <= 0):
			var bpmSpeed = 1
			
			if (idleDanceSpeed):
				bpmSpeed = (MusicController.bpm * MusicController.song_speed) / 120
			
			if (lastIdleDance == "danceLEFT"):
				$AnimatedSprite.speed_scale = bpmSpeed
				$AnimatedSprite.play("danceRIGHT", -1)
			elif (lastIdleDance == "danceRIGHT"):
				$AnimatedSprite.speed_scale = bpmSpeed
				$AnimatedSprite.play("danceLEFT", -1)
				
			lastIdleDance = $AnimatedSprite.animation
			
func _on_AnimationPlayer_animation_finished(anim_name):
	if Engine.editor_hint:
		return
	if (anim_name != get_idle_anim()):
		if (get_idle_anim() == "idle"):
			$AnimatedSprite.play(get_idle_anim())
		else:
			if (get_idle_anim() != "idle"):
					match (anim_name):
						"singRIGHT":
							$AnimatedSprite.play("danceRIGHT")
							lastIdleDance = "danceLEFT"
						"singLEFT":
							$AnimatedSprite.play("danceLEFT")
							lastIdleDance = "danceRIGHT"
						_:
							$AnimatedSprite.play(lastIdleDance)

func get_idle_anim():
	if (idleDance):
		var doesDanceLeftLol = false
		
		for anim in $AnimatedSprite.frames.get_animation_names():
			if anim == "danceLEFT":
				doesDanceLeftLol = true
		
		if (doesDanceLeftLol):
			return "danceLEFT"
	
	return "idle"


func _on_AnimatedSprite_animation_finished():
	if Engine.editor_hint:
		return
	#if ($AnimatedSprite.animation != get_idle_anim()):
#		if (get_idle_anim() == "idle"):
#			$AnimationPlayer.play(get_idle_anim(), -1, 1, true)
#		else:
		#if (get_idle_anim() != "idle"):
		#	match ($AnimatedSprite.animation):
		#		"singRIGHT":
		#			$AnimatedSprite.play("danceRIGHT")
		#			lastIdleDance = "danceLEFT"
		#		"singLEFT":
		#			$AnimatedSprite.play("danceLEFT")
		#			lastIdleDance = "danceRIGHT"
		#		_:
		#			$AnimatedSprite.play(lastIdleDance)
