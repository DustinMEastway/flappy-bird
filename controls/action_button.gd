extends Button
class_name ActionButton

export var action: String

func _ready():
	connect("button_down", self, "_button_down")
	connect("button_up", self, "_button_up")

func _button_down() -> void:
	if (_is_action_valid()):
		Input.action_press(action)

func _button_up() -> void:
	if (_is_action_valid()):
		Input.action_release(action)

func _is_action_valid() -> bool:
	return action and action.length() > 0
