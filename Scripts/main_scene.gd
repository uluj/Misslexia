extends Node2D

# Reference to the health bar (adjusted to the correct path)
@onready var health_bar = $"/root/MainScene/Control/HealthBar"  # Adjusted the path to HealthBar node

# Spawn olan nesneyi tutacak değişkenler
var spawned_object1 = null
var spawned_object2 = null

# Spawn butonu tetiklenince
func _on_button_pressed():
	# Randomize boolean values each time the button is pressed
	var is_it_true1 = randi_range(0, 1) == 1  # Random true or false
	var is_it_true2 = randi_range(0, 1) == 1  # Random true or false
	
	# Compare the two bools and print success/fail message
	if is_it_true1 == is_it_true2:
		print("Belge 1: %s, Belge 2: %s, Outcome: Success" % [is_it_true1, is_it_true2])
		# No need to remove a health point on success
	else:
		print("Belge 1: %s, Belge 2: %s, Outcome: Fail" % [is_it_true1, is_it_true2])
		# Call the method to update the health bar on failure
		health_bar.update_health_bar(false)

# Kabul alanına girildiğinde
func _on_kabul_alani_body_entered(body):
	if body.is_in_group("movable") and body.draggable:
		var is_it_true = body.get_meta("is_it_true")
		print("Belge: %s, Kabul Edildi, Outcome: Success" % [is_it_true])
		InteractionController.any_object_dragging = false
		
		# Handle success, no objects to remove
		body.queue_free() # Remove the current object from the scene

# Reddetme alanına girildiğinde
func _on_red_alani_body_entered(body):
	if body.is_in_group("movable") and body.draggable:  # Fixed the syntax here
		var is_it_true = body.get_meta("is_it_true")
		print("Belge: %s, Reddedildi, Outcome: Fail" % [is_it_true])
		InteractionController.any_object_dragging = false
		
		# Handle failure, no objects to remove
		body.queue_free() # Remove the current object from the scene
