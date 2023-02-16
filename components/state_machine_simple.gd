class_name SimpleStateMachine
extends Node

## A simple state machine for Godot 4.
##
## A simple state machine implementation that uses ordinary, specifically-
## named methods to manage state. [br][br]
##
## [b]How to use[/b] [br][br]
##
## 1. Create a [Node], attach a script, and extend from
## [SimpleStateMachine]. [br][br]
##
## 2. Create methods in your script to handle the game loop and events.  For
## example, to manage the state "[code]idle[/code]", define methods such as:
##
## [codeblock]
## extends SimpleStateMachine
## func idle_process(delta): ...
## func idle_physics_process(delta): ...
## func idle_unhandled_input(event): ...
## # and so on.
## [/codeblock] [br]
##
## The game loop events that are handled are [member Node._process],
## [member Node._physics_process], [member Node._input],
## [member Node._shortcut_input], [member Node._unhandled_input] and
## [member Node._unhandled_key_input]. [br][br]
##
## [b]Note:[/b] Only names that would result in valid identifiers are allowed as
## state names. [br][br]
##
## You do not need to define methods to handle all of these. Any that do not
## exist are simply ignored.  You can see what methods are called by setting the
## [member debug] option to [code]true[/code]. [br][br]
##
## [b]Transitioning between states[/b] [br][br]
##
## To transition to another state, use [member transition_to]. You do not need
## to prepend the [member method_prefix] if you have specified one (see below).
## [br][br]
##
## Two special methods can also be defined which are called when transitioning
## from one state to another: [code]<state>_enter()[/code] and
## [code]<state>_exit()[/code].
##
## [codeblock]
## func idle_exit(): ...
## func idle_enter(): ...
## [/codeblock]  [br]
##
## These are activated once per transition, if they are defined. [br][br]
##
## The [member method_prefix] property allows you to "namespace" your
## state-related methods.  If you set [member method_prefix], you will need to
## name all of your methods appropriately, e.g. using the prefix
## "[code]my_prefix_[/code]":
##
## [codeblock]
## func my_prefix_idle_enter(): ...
## func my_prefix_idle_process(delta): ...
## func my_prefix_idle_unhandled_input(delta): ...
## func my_prefix_idle_exit(): ...
## # and so on.
## [/codeblock] [br]
##
## Finally, don't forget to set the [member initial_state]!

## No state
const UNINITIALISED_STATE := StringName("")

## Emitted when a state is entered.
signal state_entered(state:String)

## Emitted when a state is exited.
signal state_exited(state:String)

## The initial state.
@export_placeholder("Initial state") var initial_state:String

## Optional method prefix (e.g. [code]my_state_machine_[/code]) to help 
## separate methods.
@export var method_prefix:String = ""

## Enable debugging to warn about expected (but missing) methods.  [b]Note:[/b]
## enabling this can generate a [i]lot[/i] of warnings.
@export var debug:bool = false

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
