extends KinematicBody2D
class_name Player

var _jump_velocity: float = -4
var _velocity_y: float = 0

func _physics_process(delta):
	_velocity_y += GameService.gravity * delta

	if (Input.is_action_just_pressed('ui_accept')):
		$AnimationPlayer.play('fly')
		_velocity_y = _jump_velocity

	position.y += _velocity_y
