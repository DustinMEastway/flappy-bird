extends Node2D

var _background: Sprite
var _background_loop_point: int = -413
var _background_speed: int = 30
var _ground: Sprite
var _ground_speed: int = 60
var _screen_size := Vector2(
	ProjectSettings.get('display/window/size/width'),
	ProjectSettings.get('display/window/size/height')
)

func _ready():
	_add_background()
	var player: Player = load('res://player.tscn').instance()
	player.position = _screen_size / 2
	add_child(player)

func _process(delta):
	if (Input.is_action_pressed('ui_cancel')):
		get_tree().quit()

	_background.position.x -= _background_speed * delta
	_ground.position.x -= _ground_speed * delta

	if (_background.position.x < _background_loop_point):
		_background.position.x -= _background_loop_point
	if (_ground.position.x < -_screen_size.x):
		_ground.position.x += _screen_size.x

func _add_background():
	_background = Sprite.new()
	_background.centered = false
	_background.texture = load('res://images/background.png')
	add_child(_background)

	var ground_image = load('res://images/ground.png')
	var ground_size = ground_image.get_size()
	_ground = Sprite.new()
	_ground.centered = false
	_ground.position = Vector2(0, _screen_size.y - ground_image.get_size().y)
	_ground.texture = ground_image
	add_child(_ground)
