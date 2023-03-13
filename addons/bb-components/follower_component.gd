extends AnimatedComponent
class_name FollowerComponent

## Emitted when the [member _target_node] is looking towards the target position.
signal looked_at(target_position : Vector2)

## Emitted when the [member _target_node] is looking [i]directly[/i] at the
## target position.
signal looked_directly_at(target_position : Vector2)

@export_category("FollowerComponent")

## The node to target.
@export var _target_node : Node2D

# The position the node is looking at.
var _look_position:Vector2:
	get=get_look_position

## Return the position the node is looking at.
func get_look_position() -> Vector2: return _look_position
	
func _ready() -> void:
	super()

	# Assign the target node.	
	_target_node = get_parent() as Node2D
	assert(_target_node, "FollowerComponent must be a child of a Node2D node in %s." % [str(get_path())])

func _look_at(target_position : Vector2) -> void:
	if enabled:
		# Keep track of the old look position so we can check later if we need
		# to emit signals.
		var old_look_position := _look_position
		
		# Look towards the cursor.
		_look_position = lerp(_look_position, target_position, smoothing)
		_target_node.look_at(_look_position)
		
		# Emit signals if required.
		if old_look_position != _look_position:
			if _look_position.is_equal_approx(target_position):
				looked_at.emit(_look_position)
			if _look_position == target_position:
				looked_directly_at.emit(_look_position)
