extends Node3D

# Preload sounds to randomise their execution later
const footsteps_array = [
	preload("res://Assets/Audio/Sound/footsteps_wood_single_2.mp3"),
	preload("res://Assets/Audio/Sound/footsteps_wood_single_3.mp3"),
	preload("res://Assets/Audio/Sound/footsteps_wood_single_4.mp3"),
	preload("res://Assets/Audio/Sound/footsteps_cellar_single_1.mp3"),
	preload("res://Assets/Audio/Sound/footsteps_cellar_single_2.mp3"),
	preload("res://Assets/Audio/Sound/footsteps_cellar_single_3.mp3"),
	preload("res://Assets/Audio/Sound/footsteps_cellar_single_4.mp3"),
	preload("res://Assets/Audio/Sound/footsteps_cellar_single_5.mp3"),
]

const screams_array = [
	preload("res://Assets/Audio/Sound/scream_banshee.mp3"),
	preload("res://Assets/Audio/Sound/scream_delay_1.mp3"),
	preload("res://Assets/Audio/Sound/scream_delay_2.mp3"),
]

const creaks_array = [
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

	##### Setup generic signal connections #####

	player.connect("creepy_event", play_background_music)
	player.connect("player_moved", play_sound_from_array.bind("footstep", $Audio/Footsteps, footsteps_array))

	##### Setup randomly timed (and / or randomly chosen) sounds #####

	const thunderStorm_volume_db: float = -10.0
	const rand_thunderstorm_time_min_s: float = 60.0
	const rand_thunderstorm_time_max_s: float = 180.0
	# const rand_thunderstorm_time_min_s: float = 5.0 # TODO: debug
	# const rand_thunderstorm_time_max_s: float = 5.0 # TODO: debug
	setup_randomly_timed_sound($Audio/ThunderStorm, $Audio/Timers/ThunderStormTimer, rand_thunderstorm_time_min_s, rand_thunderstorm_time_max_s, thunderStorm_volume_db, on_thunderstorm_finished, play_thunderstorm)

	const scream_volume_db: float = -30.0
	const rand_scream_time_min_s: float = 120.0
	const rand_scream_time_max_s: float = 240.0
	# const rand_scream_time_min_s: float = 2.0 # TODO: debug
	# const rand_scream_time_max_s: float = 2.0 # TODO: debug
	setup_randomly_timed_sound($Audio/Screams, $Audio/Timers/ScreamTimer, rand_scream_time_min_s, rand_scream_time_max_s, scream_volume_db, on_scream_finished, play_sound_from_array.bind("scream", $Audio/Screams, screams_array))


	const creak_volume_db: float = -20
	const rand_creak_time_min_s: float = 60.0
	const rand_creak_time_max_s: float = 120.0
	# const rand_creak_time_min_s: float = 2.0 # TODO: debug
	# const rand_creak_time_max_s: float = 2.0 # TODO: debug
	setup_randomly_timed_sound($Audio/Creaks, $Audio/Timers/CreaksTimer, rand_creak_time_min_s, rand_creak_time_max_s, creak_volume_db, on_creak_finished, play_sound_from_array.bind("creak", $Audio/Creaks, creaks_array))


func setup_randomly_timed_sound(sound_type, timer, rand_time_min: float, rand_time_max: float, volume: float, callback, sound_to_play):
	sound_type.volume_db = volume
	sound_type.connect("finished", callback)
	timer.one_shot = true
	timer.wait_time = randf_range(rand_time_min, rand_time_max)
	timer.connect("timeout", sound_to_play)
	timer.start()


##### Functions: play sound and music #####

func play_background_music():
	if not $Audio/BackgroundMusic.is_playing():
		$Audio/BackgroundMusic.play()

# Used to play randomisable sounds from an array of similar sounds
func play_sound_from_array(_sound_name: String, audio_stream, sound_array: Array):
	var random_sound = sound_array[randi() % sound_array.size()]
	audio_stream.stream = random_sound
	audio_stream.play()
	print("%s played!" %_sound_name) # TODO: debug

func play_thunderstorm():
	if not $Audio/ThunderStorm.is_playing():
		$Audio/ThunderStorm.play()

func play_chest_opening():
	if not $Audio/ThunderStorm.is_playing():
		$Audio/ThunderStorm.play()


##### Functions: restart timers for sound and music #####

func on_thunderstorm_finished():
	$Audio/Timers/ThunderStormTimer.start()

func on_scream_finished():
	$Audio/Timers/ScreamTimer.start()

func on_creak_finished():
	$Audio/Timers/CreaksTimer.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
