extends Control

@onready var health := %StatHealth as StatHealth

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
	%DeadLabel.text = "Status: DEAD!"

func _on_check_box_toggled(button_pressed: bool) -> void:
	health.autoheal_enabled = button_pressed

func _on_stat_health_autohealing_enabled(status) -> void:
	%Autoheal.button_pressed = status

func _on_stat_health_revived() -> void:
	%DeadLabel.text = "Status: ALIVE AGAIN!"

func _on_stat_health_autohealing_started() -> void:
	%HealthProgress.modulate = Color.GREEN

func _on_stat_health_autohealing_stopped() -> void:
	%HealthProgress.modulate = Color.WHITE

func _update_status() -> void:
	%HealthProgress.max_value = health.max_health
	%HealthProgress.value = health.health
	%Revive50Percent.disabled = health.is_alive()
	%RateLabel.text = "Rate: %s/%s s" % [health.autoheal_amount, health.autoheal_rate]
	%DelayLabel.text = "Delay: %s s" % [health.autoheal_delay]
	%Autoheal.button_pressed = health.autoheal_enabled

func _on_stat_health_autohealing_counting_down(time_left) -> void:
	%DelayRemaining.max_value = health.autoheal_delay
	%DelayRemaining.value = time_left
