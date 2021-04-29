extends StateMachine

var states_names = {
	'main': 'Main',
	'title': 'Title'
}

func _ready():
	for states_name in states_names:
		var state_path = 'res://state/scene/' + states_name + '.gd'
		var state = load(state_path).new()
		state.name = states_names[states_name]
		add_child(state)

	set_state_name('Title')
