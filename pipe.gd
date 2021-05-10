extends Node2D
class_name Pipe

export var pipe_gap: float = 0 setget _set_pipe_gap
export var pipe_speed: float = 60

signal player_hit
signal point_earned

func get_width() -> float:
	var bottomShape = $HitShape/Bottom
	return scale.x * 2 * bottomShape.scale.x * bottomShape.shape.extents.x

func _ready() -> void:
	$HitShape.connect("body_entered", self, "_hit_body_entered")
	$ScoreArea.connect("body_exited", self, "_point_body_exited")

func _physics_process(delta) -> void:
	if (GameService.paused):
		return

	move_local_x(-pipe_speed * delta)

func _set_pipe_gap(new_pipe_gap: float) -> void:
	pipe_gap = new_pipe_gap
	var distance = 144 + pipe_gap / 2
	$HitShape/Bottom.position.y = distance
	$HitShape/Top.position.y = -distance
	$ScoreArea/Area.scale.y = pipe_gap / 2 / 10

func _hit_body_entered(body: Node2D) -> void:
	if (body is Player):
		emit_signal("player_hit")

func _point_body_exited(body: Node2D) -> void:
	if (body is Player):
		emit_signal("point_earned")
