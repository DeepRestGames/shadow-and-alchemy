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

const creaks = [
	preload("res://Assets/Audio/Sound/creaking_creepy_3.mp3"),
	preload("res://Assets/Audio/Sound/creaking_creepy_4.mp3"),
	preload("res://Assets/Audio/Sound/creaking_creepy_5.mp3"),
	preload("res://Assets/Audio/Sound/creaking_creepy_6.mp3"),
	preload("res://Assets/Audio/Sound/creaking_door_1.mp3"),
	preload("res://Assets/Audio/Sound/creaking_door_2.mp3"),
	preload("res://Assets/Audio/Sound/creaking_metal_1.mp3"),
	preload("res://Assets/Audio/Sound/creaking_metal_2.mp3"),
	preload("res://Assets/Audio/Sound/creaking_metal_3.mp3"),
]

# Called when the node enters the scene tree for the first time.
func _ready():
	##### Prepare background music #####

	var background_music: AudioStreamMP3 = $Audio/BackgroundMusic.stream as AudioStreamMP3
	var player: Node = get_node("Player")
	background_music.loop = true
	background_music.loop_offset = 21.333 # measures 9 to 16 included
	player.connect("startBackgroundMusic", play_backgroundMusic)
	player.connect("playerMoved", play_footstep)

	##### Setup sounds #####

	const rand_thunderstorm_min_s: float =  60.0
	const rand_thunderstorm_max_s: float = 180.0
	# const rand_thunderstorm_min_s: float = 5.0 # TODO: debug
	# const rand_thunderstorm_max_s: float = 5.0 # TODO: debug
	const thunderStorm_volume_db: float = -10.0
	setup_sound($Audio/ThunderStorm, $Timers/ThunderStormTimer, rand_thunderstorm_min_s, rand_thunderstorm_max_s, thunderStorm_volume_db, on_thunderstorm_finished, play_thunderstorm)

	const rand_scream_min_s: float = 120.0
	const rand_scream_max_s: float = 240.0
	# const rand_scream_min_s: float = 2.0 # TODO: debug
	# const rand_scream_max_s: float = 2.0 # TODO: debug
	const scream_volume_db: float = -30.0
	setup_sound($Audio/Screams, $Timers/ScreamTimer, rand_scream_min_s, rand_scream_max_s, scream_volume_db, on_scream_finished, play_scream)


	const rand_creak_min_s: float =  60.0
	const rand_creak_max_s: float = 120.0
	# const rand_creak_min_s: float = 2.0 # TODO: debug
	# const rand_creak_max_s: float = 2.0 # TODO: debug
	const creak_volume_db: float = -20
	setup_sound($Audio/Creaks, $Timers/CreaksTimer, rand_creak_min_s, rand_creak_max_s, creak_volume_db, on_creak_finished, play_creak)


##### Functions: play sound and music #####

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
	print("scream played!") # TODO: debug


func play_creak():
	var random_creak = creaks[randi() % creaks.size()]
	$Audio/Creaks.stream = random_creak
	$Audio/Creaks.play()
	print("creak played!") # TODO: debug

func play_thunderstorm():
	if not $Audio/ThunderStorm.is_playing():
		$Audio/ThunderStorm.play()

##### Functions: restart timers for sound and music #####

func on_thunderstorm_finished():
	$Timers/ThunderStormTimer.start()


func on_scream_finished():
	$Timers/ScreamTimer.start()


func on_creak_finished():
	$Timers/CreaksTimer.start()


func setup_sound(sound_type, timer, rand_min: float, rand_max: float, volume: float, callback, sound_to_play):
	sound_type.volume_db = volume
	sound_type.connect("finished", callback)
	timer.one_shot = true
	timer.wait_time = randf_range(rand_min, rand_max)
	timer.connect("timeout", sound_to_play)
	timer.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
