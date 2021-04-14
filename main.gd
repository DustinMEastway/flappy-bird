extends Node2D

var _background: Sprite
var _background_loop_point: int = -413
var _background_speed: int = 30
var _ground: Sprite
var _ground_image = load('res://images/ground.png')
var _ground_speed: int = 60

func _ready() -> void:
	_add_background()
	var player: Player = load('res://player.tscn').instance()
	player.position = GameService.screen_size / 2
	add_child(player)

func _process(delta) -> void:
	if (Input.is_action_pressed('ui_cancel')):
		get_tree().quit()

	_background.position.x -= _background_speed * delta
	_ground.position.x -= _ground_speed * delta

	if (_background.position.x < _background_loop_point):
		_background.position.x -= _background_loop_point
	if (_ground.position.x < -GameService.screen_size.x):
		_ground.position.x += GameService.screen_size.x

func _add_background() -> void:
	_background = Sprite.new()
	_background.centered = false
	_background.texture = load('res://images/background.png')
	add_child(_background)

	_ground = Sprite.new()
	_ground.centered = false
	_ground.position.y = GameService.screen_size.y - _ground_image.get_size().y
	_ground.texture = _ground_image
	add_child(_ground)
