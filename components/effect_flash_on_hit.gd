class_name EffectFlashOnHit
extends Node

const __OVERSATURATION_MULTIPLIER := 2
const __OVERSATURATION_COLOR := Color.RED * __OVERSATURATION_MULTIPLIER


@export var target_node:Node2D
@export var hurtbox_node:Node2D
@export var fade_duration := 0.5
@export var default_modulation := Color.WHITE

func _ready() -> void:
	if target_node == null:
		target_node = get_parent() as Node2D
	assert(target_node)

	if hurtbox_node == null:
		hurtbox_node = get_parent() as Node2D
	assert(hurtbox_node)

	hurtbox_node.damaged.connect(func(_amount: float):
		target_node.modulate = __OVERSATURATION_COLOR
		var tween := get_tree().create_tween()
		tween.tween_property(target_node, "modulate", default_modulation, fade_duration))
