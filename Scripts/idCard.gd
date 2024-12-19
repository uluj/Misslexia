extends CharacterBody2D
var draggable = false

func _process(_delta):
	if draggable:
		if Input.is_action_just_pressed("left_mouse"):
			print("Mouse click detected: Left mouse button just pressed.")  # Debug log for mouse click
			InteractionController.any_object_dragging = true
			self.get_parent().move_child(self, self.get_parent().get_child_count() - 1)  # Bring object to the front
		if Input.is_action_pressed("left_mouse"):
			print("Mouse is being held down: Left mouse button held.")  # Debug log for mouse hold
			global_position = get_global_mouse_position()  # Update position to follow mouse
		elif Input.is_action_just_released("left_mouse"):
			print("Mouse click released: Left mouse button just released.")  # Debug log for mouse release
			InteractionController.any_object_dragging = false

# When the mouse enters the object area
func _on_mouse_entered():
	print("Mouse hovered over object.")  # Debug log for mouse entering
	var objects = get_tree().get_nodes_in_group("movable")
	if not InteractionController.any_object_dragging:
		for obj in objects:
			if obj != self:
				obj.draggable = false
		draggable = true

# When the mouse exits the object area
func _on_mouse_exited():
	print("Mouse exited the object.")  # Debug log for mouse exiting
	if not InteractionController.any_object_dragging:
		draggable = false
