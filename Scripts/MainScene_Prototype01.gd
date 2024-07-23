extends Node3D

# Called when the node enters the scene tree for the first time.
func _ready():
	var audio_stream = $BackgroundMusic.stream as AudioStreamMP3
	audio_stream.loop = true
	audio_stream.loop_offset = 21.372
	$BackgroundMusic.play()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
