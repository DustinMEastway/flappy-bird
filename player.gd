extends KinematicBody2D
class_name Player

func _physics_process(delta):
	if (Input.is_action_just_pressed('ui_accept')):
		$AnimationPlayer.play('fly')
