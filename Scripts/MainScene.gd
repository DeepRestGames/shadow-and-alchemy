extends Node3D

##### Preload sounds to randomise their execution later #####

const thunderstorm_array = [preload("res://Assets/Audio/Sound/storm_faded.mp3")]

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

const chest_open_array = [preload("res://Assets/Audio/Sound/chest_opening_short.mp3")]


##### Setup thunderstorm #####

const thunderStorm_volume_db: float = -10.0
const rand_thunderstorm_time_min_s: float = 60.0
const rand_thunderstorm_time_max_s: float = 180.0
# const rand_thunderstorm_time_min_s: float = 5.0 # TODO: debug
# const rand_thunderstorm_time_max_s: float = 10.0 # TODO: debug

##### Setup screams #####

const scream_volume_db: float = -30.0
const rand_scream_time_min_s: float = 120.0
const rand_scream_time_max_s: float = 240.0
# const rand_scream_time_min_s: float = 2.0 # TODO: debug
# const rand_scream_time_max_s: float = 5.0 # TODO: debug

##### Setup creaks #####

const creak_volume_db: float = -20
const rand_creak_time_min_s: float = 60.0
const rand_creak_time_max_s: float = 120.0
# const rand_creak_time_min_s: float = 2.0 # TODO: debug
# const rand_creak_time_max_s: float = 5.0 # TODO: debug


# Called when the node enters the scene tree for the first time.
func _ready():
	play_intro_sounds()

	var player: Node = get_node("Player")
	var chest_top_collision_1: Node = get_node("Chests/ChestTop/ChestTopCollision")
	var chest_top_collision_2: Node = get_node("Props/BloodChest/ChestTop/ChestTopCollision")

	##### Setup background music #####

	$Audio/BackgroundMusic.volume_db = -10
	var background_music: AudioStreamMP3 = $Audio/BackgroundMusic.stream as AudioStreamMP3
	background_music.loop = true
	background_music.loop_offset = 21.333 # measures 9 to 16 included
	player.connect("creepy_event", play_background_music)

	##### Setup footsteps #####

	$Audio/Footsteps.volume_db = -10
	player.connect("player_moved", play_sound_from_array.bind("footstep", $Audio/Footsteps, footsteps_array))

	##### Setup chest opening #####

	$Audio/ChestOpening.volume_db = -5
	chest_top_collision_1.connect("chest_opened", play_sound_from_array.bind("chest opening", $Audio/ChestOpening, chest_open_array))
	chest_top_collision_2.connect("chest_opened", play_sound_from_array.bind("chest opening", $Audio/ChestOpening, chest_open_array))

	##### Setup randomly timed sounds #####

	setup_randomly_timed_sound($Audio/ThunderStorm, $Audio/Timers/ThunderStormTimer,
														 rand_thunderstorm_time_min_s, rand_thunderstorm_time_max_s, thunderStorm_volume_db,
														 on_sound_finished.bind($Audio/Timers/ThunderStormTimer, rand_thunderstorm_time_min_s, rand_thunderstorm_time_max_s),
														 play_sound_from_array.bind("thunderstorm", $Audio/ThunderStorm, thunderstorm_array))

	setup_randomly_timed_sound($Audio/Screams, $Audio/Timers/ScreamTimer,
														 rand_scream_time_min_s, rand_scream_time_max_s, scream_volume_db,
														 on_sound_finished.bind($Audio/Timers/ScreamTimer, rand_scream_time_min_s, rand_scream_time_max_s),
														 play_sound_from_array.bind("scream", $Audio/Screams, screams_array))

	setup_randomly_timed_sound($Audio/Creaks, $Audio/Timers/CreaksTimer,
														 rand_creak_time_min_s, rand_creak_time_max_s, creak_volume_db,
														 on_sound_finished.bind($Audio/Timers/CreaksTimer, rand_creak_time_min_s, rand_creak_time_max_s),
														 play_sound_from_array.bind("creak", $Audio/Creaks, creaks_array))


##### Function to setup sounds which are governed by a random timer #####

func setup_randomly_timed_sound(sound_stream, timer, rand_time_min: float, rand_time_max: float, volume: float, callback, sound_to_play):
	sound_stream.volume_db = volume
	sound_stream.connect("finished", callback)
	timer.one_shot = true
	timer.wait_time = generate_random_time(rand_time_min, rand_time_max)
	timer.connect("timeout", sound_to_play)
	timer.start()


##### Functions to play sound and music #####

func play_background_music():
	if not $Audio/BackgroundMusic.is_playing():
		$Audio/BackgroundMusic.play()

# Used to play randomisable sounds from an array of similar sounds
func play_sound_from_array(_sound_name: String, audio_stream, sound_array: Array):
	var random_sound = sound_array[randi() % sound_array.size()]
	audio_stream.stream = random_sound
	audio_stream.play()
	# print("%s played!" %_sound_name) # TODO: debug print


##### Function randomise the timer countdown period between a minimum and maximum value in seconds #####

func generate_random_time(rand_time_min: float, rand_time_max: float) -> float:
	return randf_range(rand_time_min, rand_time_max)


##### Function to restart timers for sound and music #####

func on_sound_finished(sound_timer: Timer, rand_time_min: float, rand_time_max: float):
	sound_timer.wait_time = generate_random_time(rand_time_min, rand_time_max)
	sound_timer.start()
	# print("%s random time: %f" %[sound_timer.name, sound_timer.wait_time]) # TODO: debug print


##### Function to play sounds only for the game's intro #####

enum Audio_Players_Names
{
	WALKING = 0,
	DOOR_OPEN,
	DOOR_CLOSE,
	FOUR_STEPS,
	CANDLE_LIGHT
}

func play_intro_sounds():
	var audio_players: Array = [
		AudioStreamPlayer.new(), # WALKING
		AudioStreamPlayer.new(), # DOOR_OPEN
		AudioStreamPlayer.new(), # DOOR_CLOSE
		AudioStreamPlayer.new(), # FOUR_STEPS
		AudioStreamPlayer.new(), # CANDLE_LIGHT
	]

	for audio_player in audio_players:
		add_child(audio_player)

	audio_players[Audio_Players_Names.WALKING].stream = load("res://Assets/Audio/Sound/walking_outside.mp3")
	audio_players[Audio_Players_Names.DOOR_OPEN].stream = load("res://Assets/Audio/Sound/door_open.mp3")
	audio_players[Audio_Players_Names.DOOR_CLOSE].stream = load("res://Assets/Audio/Sound/door_close.mp3")
	audio_players[Audio_Players_Names.FOUR_STEPS].stream = load("res://Assets/Audio/Sound/footsteps_cellar_four.mp3")
	audio_players[Audio_Players_Names.CANDLE_LIGHT].stream = load("res://Assets/Audio/Sound/candle_lighting.mp3")

	audio_players[Audio_Players_Names.WALKING].connect("finished", audio_players[Audio_Players_Names.DOOR_OPEN].play)
	audio_players[Audio_Players_Names.DOOR_OPEN].connect("finished", audio_players[Audio_Players_Names.DOOR_CLOSE].play)
	audio_players[Audio_Players_Names.DOOR_CLOSE].connect("finished", audio_players[Audio_Players_Names.FOUR_STEPS].play)
	audio_players[Audio_Players_Names.FOUR_STEPS].connect("finished", audio_players[Audio_Players_Names.CANDLE_LIGHT].play)
	audio_players[Audio_Players_Names.CANDLE_LIGHT].connect("finished", on_all_sounds_finished.bind(audio_players))

	audio_players[Audio_Players_Names.FOUR_STEPS].volume_db = -10

	audio_players[Audio_Players_Names.WALKING].play()

func on_all_sounds_finished(audio_players: Array):
	for audio_player in audio_players:
		audio_player.queue_free()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
