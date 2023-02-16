extends Control

@onready var health := %StatHealth as StatHealth
@onready var autoheal := %StatAutoHeal as StatAutoHeal

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

func _on_stat_health_changed(_value: float) -> void:
	_update_status()

func _on_stat_health_died() -> void:
	%StatusLabel.text = "Status: DEAD!"

func _on_check_box_toggled(button_pressed: bool) -> void:
	autoheal.enabled = button_pressed

func _on_stat_health_revived() -> void:
	%StatusLabel.text = "Status: ALIVE AGAIN!"

func _on_stat_auto_heal_autohealing_counting_down(time_left) -> void:
	%DelayRemaining.max_value = autoheal.autoheal_delay
	%DelayRemaining.value = time_left

func _on_stat_auto_heal_autohealing_started() -> void:
	%HealthProgress.modulate = Color.GREEN

func _on_stat_auto_heal_autohealing_stopped() -> void:
	%HealthProgress.modulate = Color.WHITE

func _on_stat_auto_heal_autohealing_enabled(status) -> void:
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
