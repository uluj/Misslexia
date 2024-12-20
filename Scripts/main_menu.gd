extends Node2D

@onready var music_player = $AudioStreamPlayer2D/AudioStreamPlayer

func _ready():
	music_player.play()


func _on_texture_button_pressed():
	var main_scene = load("res://Scenes/main_scene.tscn").instantiate()
	get_tree().root.add_child(main_scene)
	queue_free()
