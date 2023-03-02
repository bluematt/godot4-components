@icon("./hitbox.svg")
class_name BBHitbox
extends Area2D

## A simple hitbox component.
##
## @tutorial(Documentation): https://github.com/bluematt/godot4-components/blob/main/doc/hitbox.md

## Emitted when the hitbox hits a [BBHurtbox].
signal hit(hurtbox: BBHurtbox, amount: float)

## The amount of damage this hitbox applies.
@export var damage_amount := 1.0

func _on_hurtbox_entered(hurtbox:BBHurtbox) -> void:
	hurtbox.damage(damage_amount)
	hit.emit(hurtbox, damage_amount)

## Set the damage amount.
func set_damage_amount(new_damage_amount : float) -> void:
	damage_amount = new_damage_amount

## Get the damage amount.
func get_damage_amount() -> float:
	return damage_amount
