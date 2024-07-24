extends Node3D

var footstep_sounds = [preload("res://Assets/Audio/Sound/footsteps_wood_single_1.mp3"), preload("res://Assets/Audio/Sound/footsteps_wood_single_2.mp3"), preload("res://Assets/Audio/Sound/footsteps_wood_single_3.mp3")]

# Called when the node enters the scene tree for the first time.
func _ready():
	# Prepare creepy background music stream
	var audio_stream = $BackgroundMusic.stream as AudioStreamMP3
	audio_stream.loop = true
	audio_stream.loop_offset = 21.372

	# Start creepy background music stream when player emits `startBackgroundMusic` signal
	var player = get_node("Player")
	player.connect("startBackgroundMusic", play_backgroundMusic)

	# Load multiple footsteps to be called randomly when player walks
	player.connect("playerMoved", play_footstep)

func play_backgroundMusic():
	if not $BackgroundMusic.is_playing():
		$BackgroundMusic.play()

func play_footstep():
	var random_footstep = footstep_sounds[randi() % footstep_sounds.size()]
	$Footsteps.stream = random_footstep
	$Footsteps.play()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
