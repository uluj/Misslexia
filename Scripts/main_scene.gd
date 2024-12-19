extends Node2D

# Nesne prefab (sahnede ekli olan tscn dosyasına atıf)
var spawn_scene: PackedScene = preload("res://Scenes/onay_bekleyen_nesne.tscn")
@onready var OnayBekleyenNesneler = $OnayBekleyenNesneler

# Spawn olan nesneyi tutacak değişken
var spawned_object = null

# Mouse ile tutulan nesne
var held_object = null

# Fonksiyon: Yeni bir nesne oluştur ve belirli parametrelerle sahneye ekle
func spawn_object(is_it_true: bool, spawn_position: Vector2) -> Node:
	"""
	Spawns an object with the given `is_it_true` parameter and position.

	Parameters:
		is_it_true (bool): A parameter to set behavior or state of the spawned object.
		position (Vector2): The position to place the spawned object.

	Returns:
		Node: The spawned object instance.
	"""
	if spawn_scene:
		spawned_object = spawn_scene.instantiate()
		OnayBekleyenNesneler.add_child(spawned_object)
		spawned_object.position = spawn_position

		# Pass the `is_it_true` parameter if the object has a matching function
		if spawned_object.has_method("set_is_it_true"):
			spawned_object.set_is_it_true(is_it_true)
		
		return spawned_object
	else:
		print("Error: spawn_scene is not set.")
		return null

# Spawn butonu tetiklenince
func _on_button_pressed():
	if spawn_scene:
		# Yeni bir nesne oluştur ve sahneye ekle
		spawned_object = spawn_scene.instantiate()
		OnayBekleyenNesneler.add_child(spawned_object)
		spawned_object.position = Vector2(609, 277) # Başlangıç pozisyonu

# Kabul alanına girildiğinde
func _on_kabul_alani_body_entered(body):
	if body.is_in_group("movable") and body.draggable:
		print("Onaylandı")
		InteractionController.any_object_dragging = false
		body.queue_free() # Nesneyi sahneden kaldır

# Reddetme alanına girildiğinde
func _on_red_alani_body_entered(body):
	if body.is_in_group("movable") and body.draggable:
		print("Reddedildi")
		InteractionController.any_object_dragging = false
		body.queue_free() # Nesneyi sahneden kaldır
