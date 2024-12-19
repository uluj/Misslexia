extends Node2D
@onready var HealthBar = $Control/HealthBar
@onready var AnimationPlayer_: AnimationPlayer = $AnimationPlayer
@onready var randomDocumentCreator = $randomDocumentCreator
var currentDocument : bool
var is_there_any_document : bool
var healthFlag = 0
var charAnimationArray:Array = [["char1Gelis","char1OnayliGidis","char1RedGidis"],["char2Gelis","char2OnayGidis","char2RedGidis"]]
var charAnimationIndex = null

func _ready():
	start_character()

func _on_onay_button_pressed():
	if is_there_any_document:
		AnimationPlayer_.play(charAnimationArray[charAnimationIndex][1])
		randomDocumentCreator.visible = false
		if currentDocument == false:
			HealthBar.get_child(healthFlag).visible = false
			healthFlag += 1
		is_there_any_document = false
		if healthFlag == 5:
			get_tree().change_scene_to_file("res://Scenes/EndScene.tscn")
			return
		await get_tree().create_timer(1).timeout
		start_character()


func _on_red_button_pressed():
	if is_there_any_document:
		AnimationPlayer_.play(charAnimationArray[charAnimationIndex][2])
		randomDocumentCreator.visible = false
		if currentDocument == true:
			HealthBar.get_child(healthFlag).visible = false
			healthFlag += 1
		is_there_any_document = false
		if healthFlag == 5:
			get_tree().change_scene_to_file("res://Scenes/EndScene.tscn")
			return
		await get_tree().create_timer(1).timeout
		start_character()

func start_character():
	charAnimationIndex = randi_range(0, 1)
	AnimationPlayer_.play(charAnimationArray[charAnimationIndex][0])
	await get_tree().create_timer(1).timeout
	randomDocumentCreator._on_create_new_documents_pressed()
	randomDocumentCreator.visible = true
