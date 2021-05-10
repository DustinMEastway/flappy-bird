extends State

func enter(params) -> void:
	.enter(params)
	SceneStateMachine.goto_scene("res://title.tscn")

func process(delta) -> void:
	.process(delta)
	if (Input.is_action_just_released("ui_accept")):
		SceneStateMachine.state_name = SceneStateMachine.States.MAIN
	elif (Input.is_action_just_released("ui_cancel")):
		get_tree().quit()
