extends Control

@onready var health := %HealthComponent as BCHealthComponent
@onready var autoheal := %AutoHealComponent as BCAutoHealComponent

func _ready() -> void:
	_update_status()

func _on_damage_10_button_pressed() -> void:
	health.damage(10)

func _on_damage_25_button_pressed() -> void:
	health.damage(25)

func _on_heal_10_button_pressed() -> void:
	health.heal(10)

func _on_heal_all_button_pressed() -> void:
	health.heal_fully()

func _on_revive_50_percent_pressed() -> void:
	health.revive(health.max_health * 0.5)
	
func _on_health_component_changed(value : float) -> void:
	_update_status()
	
func _on_health_component_died() -> void:
	%StatusLabel.text = "Status: DEAD!"

func _on_check_box_toggled(button_pressed : bool) -> void:
	autoheal.enabled = button_pressed

func _on_health_component_revived() -> void:
	%StatusLabel.text = "Status: ALIVE AGAIN!"

func _on_auto_heal_component_autoheal_counting_down(time_left : float) -> void:
	%DelayRemaining.max_value = autoheal.autoheal_delay
	%DelayRemaining.value = time_left

func _on_auto_heal_component_autoheal_started() -> void:
	%HealthProgress.modulate = Color.GREEN
	
func _on_auto_heal_component_autoheal_stopped() -> void:
	%HealthProgress.modulate = Color.WHITE

func _on_auto_heal_component_autoheal_enabled(status : bool) -> void:
	%AutohealCheckbox.button_pressed = status

func _update_status() -> void:
	%HealthProgress.max_value = health.max_health
	%HealthProgress.value = health.health
	%Damage10Button.disabled = health.is_dead()
	%Damage25Button.disabled = health.is_dead()
	%Heal10Button.disabled = health.is_dead()
	%HealAllButton.disabled = health.is_dead() or health.is_maxed()
	%Revive50Percent.disabled = health.is_alive()
	%RateLabel.text = "Rate: %s/%s s" % [autoheal.autoheal_amount, autoheal.autoheal_rate]
	%DelayLabel.text = "Delay: %s s" % [autoheal.autoheal_delay]
	%AutohealCheckbox.button_pressed = autoheal.enabled














