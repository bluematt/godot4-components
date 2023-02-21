class_name EffectFlashOnHit
extends Node

@export var target_node:Node2D
@export var hurtbox_node:Node2D
@export var fade_duration := 0.5
@export var default_modulation := Color.WHITE
@export var flash_modulation := Color.RED
@export var saturation := 1.0

@onready var __flash:EffectFlash

func _ready() -> void:
	if target_node == null:
		target_node = get_parent() as Node2D
	assert(target_node, ("No target_node:Node2D node specified in %s. Select " +
		"one, or reparent this component as a child of a Node2D node.") 
		% [str(get_path())])

	if hurtbox_node == null:
		hurtbox_node = get_parent() as InteractHurtbox
	assert(hurtbox_node, ("No hurtbox_node:InteractHurtbox component " + 
		"specified in %s. Select one, or reparent this component as a child " +
		"of a InteractHurtbox component.") % [str(get_path())])
		
	__flash = EffectFlash.new()
	__flash.target_node = target_node
	__flash.fade_duration = fade_duration
	__flash.default_modulation = default_modulation
	__flash.flash_modulation = flash_modulation
	__flash.saturation = saturation

	add_child(__flash)

	hurtbox_node.damaged.connect(func(_damage: float):
		__flash.flash())

#	hurtbox_node.damaged.connect(func(_amount: float):
#		target_node.modulate = flash_modulation * saturation
#		var tween := get_tree().create_tween()
#		tween.tween_property(target_node, "modulate", default_modulation, fade_duration))
