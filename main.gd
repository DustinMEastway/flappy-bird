extends Node2D

var _background: Sprite
var _background_loop_point: int = -413
var _background_speed: int = 30
var _ground: Sprite
var _ground_image = load('res://images/ground.png')
var _ground_speed: int = 60
var _pipe_at_end: Pipe
var _pipes: Array = []
var _pipe_min_height = 32

func _ready() -> void:
	_add_background()
	_add_player()
	_add_pipes()
	_add_ground()
	_add_hit_area()
	GameService.paused = false

func _process(delta) -> void:
	if (GameService.paused):
		return

	_background.position.x -= _background_speed * delta
	_ground.position.x -= _ground_speed * delta

	if (_background.position.x < _background_loop_point):
		_background.position.x -= _background_loop_point
	if (_ground.position.x < -GameService.screen_size.x):
		_ground.position.x += GameService.screen_size.x

	for pipe in _pipes:
		if (pipe.position.x < -pipe.get_width() / 2):
			_move_pipe_to_end(pipe)

func _add_background() -> void:
	_background = Sprite.new()
	_background.centered = false
	_background.texture = load('res://images/background.png')
	add_child(_background)

func _add_ground() -> void:
	_ground = Sprite.new()
	_ground.centered = false
	_ground.position.y = GameService.screen_size.y - _ground_image.get_size().y
	_ground.texture = _ground_image
	add_child(_ground)

func _add_hit_area() -> void:
	var hit_size = Vector2(
		GameService.screen_size.x,
		_ground_image.get_size().y
	)
	var hit_area = Area2D.new()
	hit_area.connect("body_entered", self, "_hit_body_entered")
	var top = CollisionShape2D.new()
	top.position = Vector2(GameService.screen_size.x / 2, -hit_size.y)
	top.scale = hit_size / 10
	top.shape = RectangleShape2D.new()
	hit_area.add_child(top)
	var bottom = CollisionShape2D.new()
	bottom.position = Vector2(
		GameService.screen_size.x / 2,
		GameService.screen_size.y - hit_size.y / 2
	)
	bottom.scale = hit_size / 2 / 10
	bottom.shape = RectangleShape2D.new()
	hit_area.add_child(bottom)
	add_child(hit_area)

func _add_pipes() -> void:
	var pipe_resource = load('res://pipe.tscn')
	var max_pipes = 5
	for _i in range(max_pipes):
		var pipe: Pipe = pipe_resource.instance()
		pipe.connect('player_hit', self, "_on_player_hit")
		_move_pipe_to_end(pipe)
		_pipes.append(pipe)
		add_child(pipe)

func _add_player() -> void:
	var player: Player = load('res://player.tscn').instance()
	player.position = GameService.screen_size / 2
	add_child(player)

func _hit_body_entered(body: Node2D) -> void:
	if (body is Player):
		_on_player_hit()

func _on_player_hit() -> void:
	GameService.paused = true

func _move_pipe_to_end(pipe: Pipe) -> void:
	var screen_size = GameService.screen_size
	if (_pipe_at_end == null):
		pipe.position.x = screen_size.x
	else:
		pipe.position.x = _pipe_at_end.position.x + 2 * _pipe_at_end.get_width()

	pipe.pipe_gap = 100
	pipe.position.y = RandomService.randf_range(
		_pipe_min_height + pipe.pipe_gap / 2,
		(
			GameService.screen_size.y
			- _pipe_min_height
			- pipe.pipe_gap / 2
			- _ground_image.get_size().y
		)
	)
	_pipe_at_end = pipe
