extends State

func enter(params) -> void:
	.enter(params)
	SceneStateMachine.goto_scene("res://main.tscn")

func process(delta) -> void:
	.process(delta)
	if (Input.is_action_just_released("ui_cancel")):
		SceneStateMachine.state_name = SceneStateMachine.States.TITLE
