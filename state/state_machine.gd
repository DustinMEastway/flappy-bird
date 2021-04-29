extends Node
class_name StateMachine

var host: Node
var state: Node setget set_state
var state_name: String setget set_state_name, get_state_name

func set_state(new_state: Node, enter_params = null) -> void:
	if (state == new_state):
		return

	_try_exit()
	state = new_state
	_try_enter(enter_params)

func get_state_name() -> String:
	return null if state == null else state.name

func set_state_name(new_state_name: String, enter_params = null) -> void:
	set_state(get_node(new_state_name), enter_params)

func _ready():
	host = get_parent()

func _process(delta):
	if (state and state.has_method('process')):
		state.process(delta)

func _try_enter(enter_params) -> void:
	if (state):
		state.host = host
		state.machine = self

		if (state.has_method('enter')):
			state.enter(enter_params)

func _try_exit() -> void:
	if (state and state.has_method('exit')):
		state.exit()
