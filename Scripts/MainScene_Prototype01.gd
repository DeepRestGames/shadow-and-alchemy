extends Node3D

# Called when the node enters the scene tree for the first time.
func _ready():
	# Prepare creepy background music stream
	var audio_stream = $BackgroundMusic.stream as AudioStreamMP3
	audio_stream.loop = true
	audio_stream.loop_offset = 21.372

	# Start creepy background music stream when player emits `startBackgroundMusic` signal
	var player = get_node("Player")
	player.connect("startBackgroundMusic", playBackgroundMusic)

func playBackgroundMusic():
	if not $BackgroundMusic.is_playing():
		$BackgroundMusic.play()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
