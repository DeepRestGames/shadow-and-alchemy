extends Node3D

@onready var animation_player = $AnimationPlayer

func put_away():
	animation_player.play("disappear")
	
func pull_out():

	animation_player.play("appear")
