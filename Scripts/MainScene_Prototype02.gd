extends Node3D

# Preload sounds to randomise their execution later
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

const screams = [
	preload("res://Assets/Audio/Sound/scream_banshee.mp3"),
	preload("res://Assets/Audio/Sound/scream_delay_1.mp3"),
	preload("res://Assets/Audio/Sound/scream_delay_2.mp3"),
]

# Called when the node enters the scene tree for the first time.
func _ready():
	# Prepare audio
	var background_music: AudioStreamMP3 = $Audio/BackgroundMusic.stream as AudioStreamMP3
	var player: Node = get_node("Player")

	background_music.loop = true
	background_music.loop_offset = 21.372

	player.connect("startBackgroundMusic", play_backgroundMusic)
	player.connect("playerMoved", play_footstep)

	# Prepare timers for ambient sounds
	const rand_thunderstorm_min_s: float =  60.0
	const rand_thunderstorm_max_s: float = 180.0
	$Timers/ThunderStormTimer.wait_time = randf_range(rand_thunderstorm_min_s, rand_thunderstorm_max_s)
	$Timers/ThunderStormTimer.connect("timeout", play_thunderstorm)
	$Timers/ThunderStormTimer.connect("finished", on_thunderstorm_finished)
	$Timers/ThunderStormTimer.start()

	const rand_scream_min_s: float = 120.0
	const rand_scream_max_s: float = 240.0
	$Audio/Screams.volume_db = -40
	$Timers/ScreamTimer.wait_time = randf_range(rand_scream_min_s, rand_scream_max_s)
	$Timers/ScreamTimer.connect("timeout", play_scream)
	$Timers/ScreamTimer.connect("finished", on_scream_finished)
	$Timers/ScreamTimer.start()


func play_backgroundMusic():
	if not $Audio/BackgroundMusic.is_playing():
		$Audio/BackgroundMusic.play()


func play_footstep():
	var random_footstep = footstep_sounds[randi() % footstep_sounds.size()]
	$Audio/Footsteps.stream = random_footstep
	$Audio/Footsteps.play()


func play_scream():
	var random_scream = screams[randi() % screams.size()]
	$Audio/Screams.stream = random_scream
	$Audio/Screams.play()
	pass


func play_thunderstorm():
	if not $Audio/ThunderStorm.is_playing():
		$Audio/ThunderStorm.play()


func on_thunderstorm_finished():
	$Timers/ThunderStormTimer.start()


func on_scream_finished():
	$Timers/ScreamTimer.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
