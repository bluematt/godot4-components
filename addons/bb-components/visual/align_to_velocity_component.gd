@icon("./align_to_velocity_component.svg")
extends FollowerComponent
class_name AlignToVelocityComponent

## Align a [Node2D]'s rotation to follow a [VelocityComponent].

## The [VelocityComponent] component to align to.
@export var velocity_component: VelocityComponent

func _ready() -> void:
	super()

	# Make sure a [member velocity_component] is specified
	assert(velocity_component, "No velocity_component:VelocityComponent specified in %s." % [str(get_path())])

func _process(delta: float) -> void:
	if enabled:
		if velocity_component.direction:
			_target_node.rotation = lerp_angle(_target_node.rotation, 
				velocity_component.direction.angle(), _smoothed(turning_speed, delta))
