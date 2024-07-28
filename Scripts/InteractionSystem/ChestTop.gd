class_name ChestTop
extends CSGBox3D

@onready var animation_player = $"../AnimationPlayer"

func _open():
	animation_player.play("open")
