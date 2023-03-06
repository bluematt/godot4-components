@icon("./flash.svg")
class_name BBFlash
extends Node

## Add a triggerable flash effect to a [Node2D].

## Emitted when a flash occurs.
signal flashed()

## The [Node2D] to flash.
@export var flash_node : Node2D:
	set=set_flash_node, get=get_flash_node

## Set [member flash_node].
func set_flash_node(_node : Node2D) -> void: flash_node = _node

## Get [member flash_node].
func get_flash_node() -> Node2D: return flash_node
	
## The duration of the flash (in seconds).
@export var duration := 0.2:
	set=set_duration, get=get_duration

## Set [member duration].
func set_duration(_duration : float) -> void: duration = max(0, _duration)

## Get [member duration].
func get_duration() -> float: return duration

## The node's flash color modulation.
@export var modulation := Color.RED:
	set=set_modulation, get=get_modulation

## Set [member modulation].
func set_modulation(_modulation : Color) -> void: modulation = _modulation

## Get [member modulation].
func get_modulation() -> Color: return modulation

## The saturation multiplier for the flash color.
@export var saturation := 1.0:
	set=set_saturation, get=get_saturation

## Set [member saturation].
func set_saturation(_saturation : float) -> void: saturation = _saturation

## Get [member saturation].
func get_saturation() -> float: return saturation

# The tween that manages the flash.
var __tween : Tween
	
# The node's default colour modulation.
var default_modulation := Color.WHITE

func _ready() -> void:
	if null == flash_node:
		flash_node = get_parent() as Node2D
	assert(flash_node, ("No flash_node:Node2D node specified in %s. Select " +
		"one, or reparent this component as a child of a Node2D node.") 
		% [str(get_path())])

	default_modulation = flash_node.modulate

## Activate the flash effect.
func flash():
	# Remove any existing tweens.
	if __tween and __tween.is_running(): __tween.kill()

	# Reset the node's modulation to the start colour.
	flash_node.modulate = modulation * saturation

	# Create a new flash effect.
	__tween = get_tree().create_tween()
	__tween.tween_property(flash_node, "modulate", default_modulation, duration)
	__tween.play()

	flashed.emit()
