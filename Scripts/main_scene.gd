extends Node2D

# Nesne prefab (sahnede ekli olan tscn dosyasına atıf)
var spawn_scene: PackedScene = preload("res://Scenes/idCard.tscn")
@onready var OnayBekleyenNesneler = $OnayBekleyenNesneler

# Spawn olan nesneyi tutacak değişkenler
var spawned_object1 = null
var spawned_object2 = null

# Fonksiyon: Yeni bir nesne oluştur ve belirli parametrelerle sahneye ekle
func spawn_object2(is_it_true: bool, spawn_position: Vector2) -> Node:
	"""
	Spawns an object with the given `is_it_true` parameter and spawn_position.

	Parameters:
		is_it_true (bool): A parameter to set behavior or state of the spawned object.
		spawn_position (Vector2): The position to place the spawned object.

	Returns:
		Node: The spawned object instance.
	"""
	if spawn_scene:
		var spawned_object = spawn_scene.instantiate()
		OnayBekleyenNesneler.add_child(spawned_object)
		spawned_object.position = spawn_position

		# Pass the `is_it_true` parameter if the object has a matching function
		if spawned_object.has_method("set_is_it_true"):
			spawned_object.set_is_it_true(is_it_true)
				# Play the spawn animation
		# Play the spawn animation
		if spawned_object.has_method("play_spawn_animation"):
			spawned_object.play_spawn_animation()
		
		# Attach the is_it_true value to the object for future logging
		spawned_object.set_meta("is_it_true", is_it_true)

		return spawned_object
	else:
		print("Error: spawn_scene is not set.")
		return null

# Spawn butonu tetiklenince
func _on_button_pressed():
	# Randomize boolean values each time the button is pressed
	var is_it_true1 = randi_range(0, 1) == 1  # Random true or false
	var is_it_true2 = randi_range(0, 1) == 1  # Random true or false
	
	# Spawn two objects with these random bool values
	spawned_object1 = spawn_object2(is_it_true1, Vector2(1044, 718))  # First object at position (609, 277)
	spawned_object2 = spawn_object2(is_it_true2, Vector2(844, 718))  # Second object at position (709, 277)

	# Add both objects to a shared group for easy removal
	spawned_object1.add_to_group("spawned_objects_group")
	spawned_object2.add_to_group("spawned_objects_group")

	# Compare the two bools and print success/fail message
	if is_it_true1 == is_it_true2:
		print("Belge 1: %s, Belge 2: %s, Outcome: Success" % [is_it_true1, is_it_true2])
	else:
		print("Belge 1: %s, Belge 2: %s, Outcome: Fail" % [is_it_true1, is_it_true2])

# Kabul alanına girildiğinde
func _on_kabul_alani_body_entered(body):
	if body.is_in_group("movable") and body.draggable:
		var is_it_true = body.get_meta("is_it_true")
		print("Belge: %s, Kabul Edildi, Outcome: Success" % [is_it_true])
		InteractionController.any_object_dragging = false
		
		# Remove both objects in the group
		remove_objects_in_group()
		body.queue_free() # Remove the current object from the scene

# Reddetme alanına girildiğinde
func _on_red_alani_body_entered(body):
	if body.is_in_group("movable") and body.draggable:
		var is_it_true = body.get_meta("is_it_true")
		print("Belge: %s, Reddedildi, Outcome: Fail" % [is_it_true])
		InteractionController.any_object_dragging = false
		
		# Remove both objects in the group
		remove_objects_in_group()
		body.queue_free() # Remove the current object from the scene

# Function to remove both objects in the group
func remove_objects_in_group():
	# Remove all objects in the "spawned_objects_group" group
	var objects_in_group = get_tree().get_nodes_in_group("spawned_objects_group")
	for obj in objects_in_group:
		obj.queue_free()  # Remove the object from the scene
