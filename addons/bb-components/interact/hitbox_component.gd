@icon("./hitbox.svg")
class_name BBHitbox
extends Area2D

## Inflict damage on a [BBHurtbox] component.

## Emitted when the hitbox hits a [BBHurtbox].
signal hit(hurtbox: BBHurtbox, amount: float)

## The amount of damage this hitbox applies.
@export var damage_amount := 1.0:
	set=set_damage_amount, get=get_damage_amount

## Set the damage amount.
func set_damage_amount(_damage_amount : float) -> void:
	damage_amount = max(_damage_amount, 0.0)

## Get the damage amount.
func get_damage_amount() -> float: return damage_amount

func _on_hurtbox_entered(hurtbox : BBHurtbox) -> void:
	hurtbox.apply_damage(damage_amount)
	hit.emit(hurtbox, damage_amount)

