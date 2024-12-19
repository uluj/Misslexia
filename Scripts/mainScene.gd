extends Node2D

@onready var HealthBar = $Control/HealthBar
@onready var animationPlayer = $AnimationPlayer
@onready var randomDocumentCreator = $randomDocumentCreator
@onready var onayButton = $Control/OnayButton
@onready var redButton = $Control/RedButton

var currentCharacter = 1
var healthFlag = 0

func _ready():
	randomDocumentCreator.visible = false
	play_character_animation("char1Gelis")

func play_character_animation(animation_name: String):
	animationPlayer.play(animation_name)
	animationPlayer.connect("animation_finished", self, "_on_animation_finished")

func _on_animation_finished(anim_name: String):
	if anim_name.ends_with("Gelis"):
		randomDocumentCreator.visible = true
	elif anim_name.ends_with("OnayliGidis") or anim_name.ends_with("RedGidis"):
		currentCharacter += 1
		if currentCharacter > 2:
			currentCharacter = 1
		play_character_animation("char%dGelis" % currentCharacter)

func _on_onay_button_pressed():
	if randomDocumentCreator.visible:
		randomDocumentCreator.visible = false
		if currentCharacter == 1:
			play_character_animation("char1OnayliGidis")
		elif currentCharacter == 2:
			play_character_animation("char2OnayliGidis")
		update_health(false)

func _on_red_button_pressed():
	if randomDocumentCreator.visible:
		randomDocumentCreator.visible = false
		if currentCharacter == 1:
			play_character_animation("char1RedGidis")
		elif currentCharacter == 2:
			play_character_animation("char2RedGidis")
		update_health(true)

func update_health(decrement: bool):
	if decrement:
		HealthBar.get_child(healthFlag).visible = false
		healthFlag += 1
	if healthFlag == 5:
		get_tree().change_scene_to_file("res://Scenes/EndScene.tscn")
