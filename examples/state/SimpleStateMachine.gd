extends BBSimpleStateMachine

const COLORS := [
	Color.RED,
	Color.GREEN,
	Color.BLUE,
	Color.WHITE,
]

@onready var entity := get_parent() as Node2D

# When entering idle, set the entity's modulation to a random color
# the allowed values.
func spr_rotate_idle_enter() -> void:
	entity.modulate = COLORS.pick_random()

# Do nothing when idle.
func spr_rotate_idle_process(_delta: float) -> void:
	pass

# Start rotating when [SPACE] is pressed.		
func spr_rotate_idle_unhandled_key_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_select"):
		transition_to("rotate")
	
# Before rotating, set the entity to HOT_PINK!
func spr_rotate_rotate_enter() -> void:
	entity.modulate = Color.HOT_PINK

# Rotate the entity by 15° every second.
func spr_rotate_rotate_process(_delta: float) -> void:
	entity.rotation_degrees += 15 * _delta

# Go back to idling when [SPACE] is pressed.	
func spr_rotate_rotate_unhandled_key_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_select"):
		transition_to("idle")

# Update the %State label with the new state when changing state.
func _on_state_entered(state) -> void:
	%State.text = "State: " + state
