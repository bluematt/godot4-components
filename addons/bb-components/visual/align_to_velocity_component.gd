@icon("./align_to_velocity.svg")
extends FollowerComponent
class_name AlignToVelocityComponent

## Align a [Node2D]'s rotation to follow a [VelocityComponent].

## The [VelocityComponent] component to align to.  Automatically assigned if unset and
## a child of a [VelocityComponent] component.
@export var velocity_component : VelocityComponent:
	set(velocity_component_):
		velocity_component = velocity_component_ as VelocityComponent
	get:
		return velocity_component

func _ready() -> void:
	super()

	# Make sure a [member velocity_component] is specified
	assert(velocity_component, "No velocity_component:VelocityComponent component specified in %s." % [str(get_path())])

func _process(_delta: float) -> void:
	if enabled:
		if velocity_component.get_direction():
			_target_node.rotation = lerp_angle(_target_node.rotation, 
				velocity_component.get_direction().angle(), smoothing)
