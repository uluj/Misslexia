extends Node2D

# Reference to the health bar (adjusted to the correct path)
@onready var health_bar = $"/root/MainScene/Control/HealthBar"  # Adjusted the path to HealthBar node

# References to the scene prefabs
var idCard_scene: PackedScene = preload("res://Scenes/idCard.tscn")
var document_scene: PackedScene = preload("res://Scenes/document.tscn")

# Spawn olan nesneyi tutacak değişkenler
var spawned_id_card = null
var spawned_document = null

# Spawn butonu tetiklenince
func _on_button_pressed():
	# Randomize boolean values each time the button is pressed
	var is_it_true1 = randi_range(0, 1) == 1  # Random true or false
	var is_it_true2 = randi_range(0, 1) == 1  # Random true or false
	
	# Instantiate and spawn the idCard and document scenes
	spawned_id_card = spawn_scene(idCard_scene, Vector2(1044, 718))  # Position for idCard
	spawned_document = spawn_scene(document_scene, Vector2(844, 718))  # Position for document



# Function to spawn a scene at a specific position
func spawn_scene(scene: PackedScene, position: Vector2) -> Node:
	if scene:
		var instance = scene.instantiate()
		add_child(instance)
		instance.position = position
		return instance
	else:
		print("Error: Scene is not set properly.")
		return null

# Kabul alanına girildiğinde
func _on_kabul_alani_body_entered(body):
	if body.is_in_group("movable") and body.draggable:
		var is_it_true = body.get_meta("is_it_true")
		print("Belge: %s, Kabul Edildi, Outcome: Success" % [is_it_true])
		InteractionController.any_object_dragging = false
		
		# Handle success, remove the current object from the scene
		body.queue_free() 

# Reddetme alanına girildiğinde
func _on_red_alani_body_entered(body):
	if body.is_in_group("movable") and body.draggable:  # Fixed the syntax here
		var is_it_true = body.get_meta("is_it_true")
		print("Belge: %s, Reddedildi, Outcome: Fail" % [is_it_true])
		InteractionController.any_object_dragging = false
		
		# Handle failure, remove the current object from the scene
		body.queue_free()
