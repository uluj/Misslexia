extends Area2D

# Shared variable to store the "is_it_true" state
var is_it_true = false  # Default is false, it will be set from elsewhere

# Called when the input event occurs on this Area2D
func _input(event):
	# Check if the left mouse button was pressed
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		# Convert the mouse position to the local coordinate space of the Area2D
		var local_pos = to_local(event.position)
		# Check if the mouse is within the bounds of the Area2D's collision shape
		if get_node("CollisionShape2D").shape.extents.x > 0:  # Ensure shape is valid
			# Log click event
			print("You clicked on KabulAlani!")

			# Check if the is_it_true is true and log the outcome
			if not is_it_true:
				print("Success: is_it_true is true!")
			else:
				print("Failure: is_it_true is false.")
