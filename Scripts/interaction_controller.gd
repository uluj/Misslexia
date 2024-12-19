extends Node

# Variable to track whether an object is being dragged
var any_object_dragging = false

# Called when the node enters the scene tree for the first time.
func _ready():
	# You can initialize variables or perform setup tasks here.
	pass

# Update the dragging status when a draggable object is interacted with.
func set_dragging_status(is_dragging: bool):
	any_object_dragging = is_dragging
	print("Dragging status: %s" % [any_object_dragging])

# Called when an object starts being dragged.
func on_object_drag_start():
	set_dragging_status(true)

# Called when an object is released (stopped being dragged).
func on_object_drag_end():
	set_dragging_status(false)

# Example of interacting with an object (you can add custom logic here).
func interact_with_object(obj: Node):
	if any_object_dragging:
		# Logic for interacting with the object while it is being dragged.
		print("Interacting with object: %s" % [obj.name])
	else:
		# Logic for interacting with the object when not being dragged.
		print("Not dragging any object.")
