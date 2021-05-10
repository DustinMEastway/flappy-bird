extends StateMachine

const States = {
	MAIN = "Main",
	TITLE = "Title"
}

func goto_scene(new_scene) -> void:
	if (new_scene is String):
		get_tree().change_scene(new_scene)
	elif (new_scene is PackedScene):
		get_tree().change_scene_to(new_scene)
	elif (new_scene is Node2D):
		call_deferred("_deferred_goto_scene", new_scene)
	else:
		printerr("_deferred_goto_scene does not support", typeof(new_scene))

func _ready() -> void:
	._ready()
	for states_name in States:
		var temp: String
		var state_path = "res://state/scene/" + states_name.to_lower() + ".gd"
		var state = load(state_path).new()
		state.name = States[states_name]
		add_child(state)

	set_state_name(States.TITLE)

func _deferred_goto_scene(new_scene: Node2D) -> void:
	var root = get_tree().get_root()

	# release last scene
	var old_scene = root.get_child(root.get_child_count() -1)
	old_scene.free()

	# add new scene
	root.add_child(new_scene)
	get_tree().set_current_scene(new_scene)
