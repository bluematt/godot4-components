class_name SimpleStateMachine
extends Node

## A simple state machine for Godot 4.
##
## @tutorial: https://github.com/bluematt/godot4-components/blob/main/doc/SimpleStateMachine.md

## No state
const UNINITIALISED_STATE := StringName("")

## Emitted when a state is entered.
signal state_entered(state:String)

## Emitted when a state is exited.
signal state_exited(state:String)

@export_category("SimpleStateMachine")

## The initial state.
@export_placeholder("some_state") var initial_state:String

## Optional method prefix (e.g. [code]my_state_machine_[/code]) to help 
## separate methods.
@export_placeholder("my_prefix_") var method_prefix:String = ""

## Enable debugging to warn about expected (but missing) methods.  [b]Note:[/b]
## enabling this can generate a [i]lot[/i] of warnings.
@export var debug:bool = false

# The current state.
var _state:String = UNINITIALISED_STATE

## Returns the current state.
func get_state() -> String:
	return _state

func _ready() -> void:
	# Validate initial state.
	assert(__is_valid_state(initial_state),
		"Invalid initial state '%s' in %s" % [initial_state, get_path()])

	# Validate method prefix.
	if method_prefix != "":
		assert(method_prefix.is_valid_identifier(),
			"Invalid method prefix '%s' in %s" % [method_prefix, get_path()])

	# Transition to the initial state.
	if initial_state:
		transition_to(initial_state)

## Transition to a new state.
func transition_to(new_state:String) -> void:
	# Guard against transitioning to the same state.
	if new_state == _state:
		if debug:
			push_warning("Transition to same state '%s' in %s" %
				[_state, get_path()])
		return

	# Allow for the first state to be blank.
	if _state != UNINITIALISED_STATE:
		__exit_state()

	# Check the new state is allowed.
	assert(__is_valid_state(new_state),
		"Invalid transition state '%s' in %s" % [new_state, get_path()])
	_state = new_state

	# Enter the (new) state.
	__enter_state()

# Enters the current state.
func __enter_state() -> void:
	__call_delegate_for("_enter")
	state_entered.emit(_state)

# Exits the current state.
func __exit_state() -> void:
	__call_delegate_for("_exit")
	state_exited.emit(_state)

# Delegates _process().
func _process(delta: float) -> void:
	__call_delegate_for("_process", delta)

# Delegates _physics_process().
func _physics_process(delta: float) -> void:
	__call_delegate_for("_physics_process", delta)

# Delegates _input().
func _input(event: InputEvent) -> void:
	__call_delegate_for("_input", event)
	
# Delegates _shortcut_input().
func _shortcut_input(event: InputEvent) -> void:
	__call_delegate_for("_shortcut_input", event)

# Delegates _unhandled_input().
func _unhandled_input(event: InputEvent) -> void:
	__call_delegate_for("_unhandled_input", event)

# Delegates _unhandled_key_input().
func _unhandled_key_input(event: InputEvent) -> void:
	__call_delegate_for("_unhandled_key_input", event)

# Executes the relevant delegate method, if it exists.
func __call_delegate_for(builtin:String, data:Variant=null) -> Variant:
	# Guard for valid states.
	if not __is_valid_state(_state):
		if debug:
			push_warning("Invalid state '%s' in %s" % [_state, get_path()])
		return
	
	# Guard the method exists.
	var method := __get_state_method(builtin)
	if not has_method(method):
		if debug:
			push_warning("No method '%s()' in %s" % [method, get_path()])
		return
		
	# Create a Callable method based on the delegated method name.
	var callable := Callable(self, method)

	# Bind data to the delegated method, if applicable.
	if data != null:
		callable = callable.bind(data)

	# Call the delegated method call, and return any output.
	return callable.call()

# Return whether a state is considered valid.
func __is_valid_state(some_state:String) -> bool:
	return (some_state != "" and some_state.is_valid_identifier())

# Return the StringName version of a method name.
func __get_state_method(builtin: String) -> StringName:
	return StringName(method_prefix + _state + builtin)
