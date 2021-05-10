extends Node

var gravity: float = 10
var paused: bool = false
var score = 0
var screen_size := Vector2(
	ProjectSettings.get("display/window/size/width"),
	ProjectSettings.get("display/window/size/height")
)
