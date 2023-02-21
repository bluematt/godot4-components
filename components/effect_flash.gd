class_name EffectFlash
extends Node

@export var target_node:Node2D
@export var fade_duration := 0.2
@export var default_modulation := Color.WHITE
@export var flash_modulation := Color.RED
@export var saturation := 1.0

func _ready() -> void:
	if target_node == null:
		target_node = get_parent() as Node2D
	assert(target_node, ("No target_node:Node2D node specified in %s. Select " +
		"one, or reparent this component as a child of a Node2D node.") 
		% [str(get_path())])

func flash():
	target_node.modulate = flash_modulation * saturation
	var tween := get_tree().create_tween()
	tween.tween_property(target_node, "modulate", default_modulation, fade_duration)
