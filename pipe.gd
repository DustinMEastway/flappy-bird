extends StaticBody2D
class_name Pipe

export var pipe_gap: float = 0 setget _set_pipe_gap
export var pipe_speed: float = 60

func get_width() -> float:
	return scale.x * 2 * $BottomShape.scale.x * $BottomShape.shape.extents.x

func _physics_process(delta) -> void:
	position.x -= pipe_speed * delta

func _set_pipe_gap(new_pipe_gap) -> void:
	pipe_gap = new_pipe_gap
	var distance = 144 + pipe_gap / 2
	$BottomShape.position.y = distance
	$TopShape.position.y = -distance
