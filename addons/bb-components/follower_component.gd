extends "res://addons/bb-components/animated_component.gd"

## Emitted when the [member object_node] is looking towards the target position.
signal looked_at(target_position : Vector2)

## Emitted when the [member object_node] is looking [i]directly[/i] at the
## target position.
signal looked_directly_at(target_position : Vector2)

@export_category("FollowerComponent")

## The node to rotate.
@export var object_node : Node2D:
	set=set_object_node, get=get_object_node

## Set [member object_node].
func set_object_node(_node : Node2D) -> void: object_node = _node

## Get [member object_node].
func get_object_node() -> Node2D: return object_node

# The position the node is looking at.
var __look_position:Vector2:
	get=get_look_position

## Return the position the node is looking at.
func get_look_position() -> Vector2: return __look_position
	
func _ready() -> void:
	if not object_node:
		object_node = get_parent()

	assert(object_node, ("No object_node:Node2D component specified in %s. " +
		"Select one, or reparent this component as a child of a Node2D node.")
		% [str(get_path())])

func __look_at(target_position : Vector2) -> void:
	if enabled:
		# Keep track of the old look position so we can check later if we need
		# to emit signals.
		var old_look_position := __look_position
		
		# Look towards the cursor.
		__look_position = lerp(__look_position, target_position, smoothing)
		object_node.look_at(__look_position)
		
		# Emit signals if required.
		if old_look_position != __look_position:
			if __look_position.is_equal_approx(target_position):
				looked_at.emit(__look_position)
			if __look_position == target_position:
				looked_directly_at.emit(__look_position)
