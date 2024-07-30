class_name ChestTop
extends CSGBox3D

@onready var animation_player: AnimationPlayer = $"../AnimationPlayer"

var is_open: bool = false

signal chest_opened

func _open():
	animation_player.play("open")
	is_open = true
	chest_opened.emit()


func _close():
	animation_player.play("close")
	is_open = false
