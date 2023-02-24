@icon("./hitbox.svg")
class_name InteractHitbox
extends Area2D

## A simple hitbox component.
##
## @tutorial: https://github.com/bluematt/godot4-components/blob/main/doc/InteractHitbox.md

## Emitted when the hitbox hits a hurtbox.
signal hit(hurtbox: InteractHurtbox, amount: float)

## The amount of damage this hitbox applies.
@export var damage_amount := 1.0

func _on_hurtbox_entered(hurtbox:InteractHurtbox) -> void:
	hurtbox.damage(damage_amount)
	hit.emit(hurtbox, damage_amount)
