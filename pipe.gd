extends KinematicBody2D
class_name Pipe

export var pipe_gap: float = 0 setget _set_pipe_gap
export var pipe_speed: float = 60

signal player_hit

func get_width() -> float:
	return scale.x * 2 * $BottomShape.scale.x * $BottomShape.shape.extents.x

func _physics_process(delta) -> void:
	if (GameService.paused):
		return

	var movement = -pipe_speed * delta
	var new_x = position.x + movement
	var collision = move_and_collide(Vector2(movement, 0))
	# this moves pipe to keep player form being able to push pipes around
	position.x = new_x
	if (collision):
		emit_signal('player_hit')

func _set_pipe_gap(new_pipe_gap) -> void:
	pipe_gap = new_pipe_gap
	var distance = 144 + pipe_gap / 2
	$BottomShape.position.y = distance
	$TopShape.position.y = -distance
