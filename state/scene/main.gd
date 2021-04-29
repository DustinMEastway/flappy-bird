extends State

func enter(_params) -> void:
	get_tree().change_scene('res://main.tscn')

func process(delta) -> void:
	if (Input.is_action_just_released('ui_cancel')):
		machine.state_name = 'Title'
