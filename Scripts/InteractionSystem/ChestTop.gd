class_name ChestTop
extends CSGBox3D

@onready var animation_player = $"../AnimationPlayer"

signal chest_opened


func _open():
	animation_player.play("open")
	chest_opened.emit()
