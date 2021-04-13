extends Node2D

func _ready():
	_add_background()

func _process(delta):
	if (Input.is_action_pressed('ui_cancel')):
		get_tree().quit()

func _add_background():
	var screen_size = Vector2(
		ProjectSettings.get('display/window/size/width'),
		ProjectSettings.get('display/window/size/height')
	)

	var background = Sprite.new()
	background.centered = false
	background.texture = load('res://images/background.png')
	add_child(background)

	var ground_image = load('res://images/ground.png')
	var ground_size = ground_image.get_size()
	var ground = Sprite.new()
	ground.centered = false
	ground.position = Vector2(0, screen_size.y - ground_image.get_size().y)
	ground.texture = ground_image
	add_child(ground)
