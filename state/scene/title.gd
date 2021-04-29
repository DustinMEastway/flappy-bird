extends State

func enter(_params) -> void:
	get_tree().change_scene('res://title.tscn')

func process(delta) -> void:
	if (Input.is_action_just_released('ui_accept')):
		machine.state_name = 'Main'
	elif (Input.is_action_just_released('ui_cancel')):
		get_tree().quit()
