extends Node3D

@onready var animation_player = $AnimationPlayer


# Called when the node enters the scene tree for the first time.
func _ready():
	set_process_input(false)
	animation_player.play("fade_in")
	animation_player.queue("fade_out")
	
#
func _process(_delta):
	if not animation_player.is_playing():		
		queue_free()

