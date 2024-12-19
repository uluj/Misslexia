extends Node2D

# Nesne prefab (sahnede ekli olan tscn dosyasına atıf)
var spawn_scene: PackedScene = preload("res://onay_bekleyen_nesne.tscn")
@onready var OnayBekleyenNesneler = $OnayBekleyenNesneler

# Spawn olan nesneyi tutacak değişken
var spawned_object = null

# Mouse ile tutulan nesne
var held_object = null

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

