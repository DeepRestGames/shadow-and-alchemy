extends Node3D

@onready var animation_player = $AnimationPlayer
var is_open: bool = false


func _on_open_collider_has_been_clicked():
	if not is_open:
		animation_player.play("open")
		is_open = true
