extends KinematicBody2D
class_name Player

signal player_hit

var _jump_velocity: float = -4
var _velocity_y: float = 0

func _physics_process(delta) -> void:
	if (GameService.paused):
		return

	if (Input.is_action_just_pressed("ui_accept")):
		$AnimationPlayer.play("fly")
		_velocity_y = _jump_velocity
	else:
		_velocity_y += GameService.gravity * delta

	move_local_y(_velocity_y)
