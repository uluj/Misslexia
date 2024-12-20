extends Node2D

@onready var HealthBar = $Control/HealthBar
@onready var AnimationPlayer_: AnimationPlayer = $AnimationPlayer
@onready var randomDocumentCreator = $randomDocumentCreator
@onready var music_player = $AudioStreamPlayer2D/AudioStreamPlayer
@onready var onay_sound_player = $AudioStreamPlayer2D/onaySesi
@onready var red_sound_player = $AudioStreamPlayer2D/redSesi

var currentDocument : bool
var is_there_any_document : bool
var healthFlag = 0
var charAnimationArray:Array = [["char1Gelis","char1OnayliGidis","char1RedGidis"],["char2Gelis","char2OnayliGidis","char2RedGidis"],["char3Gelis","char3OnayliGidis","char3RedGidis"]]
var charAnimationIndex = null
var IDCardRandomIndex : int = 0
var timerChangeflag = 0

@export var IDCardTextureArray : Array[Texture] = []

func _ready():
	music_player.play()
	start_character()

func _on_onay_button_pressed():
	onay_sound_player.play()
	if is_there_any_document:
		AnimationPlayer_.play(charAnimationArray[charAnimationIndex][1])
		randomDocumentCreator.visible = false
		if currentDocument == false or IDCardRandomIndex != charAnimationIndex:
			HealthBar.get_child(healthFlag).visible = false
			healthFlag += 1
		else:
			Score.score += 1
		is_there_any_document = false
		if healthFlag == 5:
			get_tree().change_scene_to_file("res://Scenes/EndScene.tscn")
			return
		await get_tree().create_timer(1).timeout
		start_character()


func _on_red_button_pressed():
	red_sound_player.play()
	if is_there_any_document:
		AnimationPlayer_.play(charAnimationArray[charAnimationIndex][2])
		randomDocumentCreator.visible = false
		if IDCardRandomIndex != charAnimationIndex:
			Score.score += 1
		elif currentDocument == true:
			HealthBar.get_child(healthFlag).visible = false
			healthFlag += 1
		else:
			Score.score += 1
		is_there_any_document = false
		if healthFlag == 5:
			get_tree().change_scene_to_file("res://Scenes/EndScene.tscn")
			return
		await get_tree().create_timer(1).timeout
		start_character()


func start_character():
	timerChangeflag += 1
	if timerChangeflag == 5:
		timerChangeflag = 0
		randomDocumentCreator.waitTime -= 0.5
		if randomDocumentCreator.waitTime < 1.5:
			randomDocumentCreator.waitTime = 1.5
	randomDocumentCreator._on_reset_timer_timeout()
	print(randomDocumentCreator.waitTime)
	IDCardRandomIndex = randi_range(0, 2)
	charAnimationIndex = randi_range(0, 2)
	print(IDCardRandomIndex)
	print(charAnimationIndex)
	randomDocumentCreator.idCardSprite.texture = IDCardTextureArray[IDCardRandomIndex]
	AnimationPlayer_.play(charAnimationArray[charAnimationIndex][0])
	await get_tree().create_timer(1).timeout
	randomDocumentCreator._on_create_new_documents_pressed()
	randomDocumentCreator.visible = true
