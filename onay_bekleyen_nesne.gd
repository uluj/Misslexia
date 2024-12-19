extends CharacterBody2D

var draggable = false


func _process(_delta):
	if draggable:
		if Input.is_action_just_pressed("left_mouse"):
			InteractionController.any_object_dragging = true
			self.get_parent().move_child(self, self.get_parent().get_child_count() - 1)
		if Input.is_action_pressed("left_mouse"):
			global_position = get_global_mouse_position()
		elif  Input.is_action_just_released("left_mouse"):
			InteractionController.any_object_dragging = false

func _on_mouse_entered():
	var objects = get_tree().get_nodes_in_group("movable")
	if not InteractionController.any_object_dragging:
		for obj in objects:
			if obj != self:
				obj.draggable = false
		draggable = true


func _on_mouse_exited():
	if not InteractionController.any_object_dragging:
		draggable = false
