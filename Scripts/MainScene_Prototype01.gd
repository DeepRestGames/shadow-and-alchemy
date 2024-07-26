extends Node3D

# Preload sounds to randomise them later
const footstep_sounds = [
	preload("res://Assets/Audio/Sound/footsteps_wood_single_2.mp3"),
	preload("res://Assets/Audio/Sound/footsteps_wood_single_3.mp3"),
	preload("res://Assets/Audio/Sound/footsteps_wood_single_4.mp3"),
	preload("res://Assets/Audio/Sound/footsteps_cellar_single_1.mp3"),
	preload("res://Assets/Audio/Sound/footsteps_cellar_single_2.mp3"),
	preload("res://Assets/Audio/Sound/footsteps_cellar_single_3.mp3"),
	preload("res://Assets/Audio/Sound/footsteps_cellar_single_4.mp3"),
	preload("res://Assets/Audio/Sound/footsteps_cellar_single_5.mp3"),
]

# Called when the node enters the scene tree for the first time.
func _ready():
	# Prepare audio
	var audio_stream = $BackgroundMusic.stream as AudioStreamMP3
	var player = get_node("Player")

	audio_stream.loop = true
	audio_stream.loop_offset = 21.372

	player.connect("startBackgroundMusic", play_backgroundMusic)
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
