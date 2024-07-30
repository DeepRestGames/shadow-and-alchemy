extends Node

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

const bucket_water_drops_array = [
	preload("res://Assets/Audio/Sound/water_drop_1.mp3"),
	preload("res://Assets/Audio/Sound/water_drop_2.mp3"),
	preload("res://Assets/Audio/Sound/water_drop_3.mp3"),
	preload("res://Assets/Audio/Sound/water_drop_4.mp3"),
	preload("res://Assets/Audio/Sound/water_drop_5.mp3"),
	preload("res://Assets/Audio/Sound/water_drop_6.mp3"),
]

const chest_open_array = [preload("res://Assets/Audio/Sound/chest_opening_short.mp3")]

const item_interact_array = [
	preload("res://Assets/Audio/Sound/drop_1.mp3"),
	preload("res://Assets/Audio/Sound/drop_2.mp3"),
	preload("res://Assets/Audio/Sound/drop_3.mp3"),
	preload("res://Assets/Audio/Sound/drop_4.mp3"),
	preload("res://Assets/Audio/Sound/drop_5.mp3"),
	preload("res://Assets/Audio/Sound/drop_6.mp3"),
]

const book_turn_page_array = [
	preload("res://Assets/Audio/Sound/book_turn_1.mp3"),
	preload("res://Assets/Audio/Sound/book_turn_2.mp3"),
	preload("res://Assets/Audio/Sound/book_turn_3.mp3"),
	preload("res://Assets/Audio/Sound/book_turn_4.mp3"),
]

const book_pickup_array = [
	preload("res://Assets/Audio/Sound/book_pickup_1.mp3"),
	preload("res://Assets/Audio/Sound/book_pickup_2.mp3"),
	preload("res://Assets/Audio/Sound/book_pickup_3.mp3"),
]

const melting_array = [preload("res://Assets/Audio/Sound/melting.mp3")]

const mortar_array = [
	preload("res://Assets/Audio/Sound/crushing_4.mp3"),
	preload("res://Assets/Audio/Sound/crushing_3.mp3"),
	preload("res://Assets/Audio/Sound/crushing_2.mp3"),
	preload("res://Assets/Audio/Sound/crushing_1.mp3"),
]


# Called when the node enters the scene tree for the first time.
func _ready():
	print("Audio scene loaded") # TODO: debug print
	# play_intro_sounds() # TODO: enable where and when required

	##### Nodes required to connect signals #####

	var alchemical_circle_1 = get_node("../Props/AlchemicalCircle/AlchemicalCirclePuzzleSlot1")
	var alchemical_circle_2 = get_node("../Props/AlchemicalCircle/AlchemicalCirclePuzzleSlot2")
	var alchemical_circle_3 = get_node("../Props/AlchemicalCircle/AlchemicalCirclePuzzleSlot3")
	var animated_book = get_node("../Player/AnimatedBook")
	var chest_top_collision_1: Node = get_node("../Chests/ChestTop/ChestTopCollision")
	var chest_top_collision_2: Node = get_node("../Props/BloodChest/ChestTop/ChestTopCollision")
	var diary = get_node("../Player/Diary")
	var item_coal = get_node("../Props/ItemCoal")
	var item_crucible = get_node("../Props/ItemCrucible")
	var item_fireplace_slot = get_node("../Props/Fireplace/GenericPuzzleSlot")
	var item_flintandsteel = get_node("../Props/ItemFlintAndSteel")
	var item_gravedirt = get_node("../Props/GraveDirt/ItemBowlOfDirt")
	var item_jarofgrapes = get_node("../Props/ItemJarOfGrapes")
	var item_mortar_slot = get_node("../Props/MortarPestle/GenericPuzzleSlot")
	var item_mushroom = get_node("../Props/ItemMushroom")
	var item_peppergrains = get_node("../Props/ItemPepperGrains")
	var opal_stone = get_node("../Props/Hand3/ItemOpalStone")
	var player: Node = get_node("../Player")
	# var item_bookblack_mercury = get_node("../Props/ItemBookBlack_Mercury")
	# var item_bookblack_salt = get_node("../Props/ItemBookBlack_Salt")
	# var item_bookblack_surfur = get_node("../Props/ItemBookBlack_Surfur")
	# var item_bookred = get_node("../Props/ItemBookRed-Leo")
	# var item_bookred_aquarius = get_node("../Props/ItemBookRed_Aquarius")
	# var item_bookred_aries = get_node("../Props/ItemBookRed_Aries")
	# var item_bookred_cancer = get_node("../Props/ItemBookRed_Cancer")
	# var item_bookred_capricorn = get_node("../Props/ItemBookRed_Capricorn")
	# var item_bookred_gemini = get_node("../Props/ItemBookRed_Gemini")
	# var item_bookred_libra = get_node("../Props/ItemBookRed_Libra")
	# var item_bookred_projection = get_node("../Props/ItemBookRed_Projection")
	# var item_bookred_sagittarius = get_node("../Props/ItemBookRed_Sagittarius")
	# var item_bookred_scorpio = get_node("../Props/ItemBookRed_Scorpio")
	# var item_bookred_taurus = get_node("../Props/ItemBookRed_Taurus")
	# var item_bookred_virgo = get_node("../Props/ItemBookRed_Virgo")


	##### Setup randomised timings #####

	const rand_thunderstorm_time_min_s: float = 120.0
	const rand_thunderstorm_time_max_s: float = 180.0
	# const rand_thunderstorm_time_min_s: float = 5.0 # TODO: debug
	# const rand_thunderstorm_time_max_s: float = 10.0 # TODO: debug

	const rand_creak_time_min_s: float = 60.0
	const rand_creak_time_max_s: float = 120.0
	# const rand_creak_time_min_s: float = 2.0 # TODO: debug
	# const rand_creak_time_max_s: float = 5.0 # TODO: debug

	const rand_bucket_water_drop_time_min_s: float = 3.0
	const rand_bucket_water_drop_time_max_s: float = 7.0
	# const rand_bucket_water_drop_time_min_s: float = 1.0 # TODO: debug
	# const rand_bucket_water_drop_time_max_s: float = 2.0 # TODO: debug


	##### Setup volumes #####

	const thunderStorm_volume_db: float = -15.0
	const creak_volume_db: float = -10
	const bucket_water_drop_volume_db: float = -20
	$Fireplace.volume_db = -15
	$Fireplace.attenuation_model = $Fireplace.ATTENUATION_INVERSE_SQUARE_DISTANCE
	$BackgroundMusic.volume_db = -15
	$Footsteps.volume_db = -15
	$ChestOpening.volume_db = -5
	$Bucket.volume_db = -15
	$Bucket.unit_size = 4
	$Bucket.attenuation_model = $Bucket.ATTENUATION_INVERSE_SQUARE_DISTANCE
	$ItemInteract.volume_db = -5
	$Mortar.volume_db = -10


	##### Setup background music #####

	var background_music: AudioStreamMP3 = $BackgroundMusic.stream as AudioStreamMP3
	background_music.loop = true
	background_music.loop_offset = 21.333 # measures 9 to 16 included


	##### Setup interaction sounds (connections) #####

	alchemical_circle_1.connect("interacted", play_sound_from_array.bind("item drop", $ItemInteract, item_interact_array))
	alchemical_circle_2.connect("interacted", play_sound_from_array.bind("item drop", $ItemInteract, item_interact_array))
	alchemical_circle_3.connect("interacted", play_sound_from_array.bind("item drop", $ItemInteract, item_interact_array))
	animated_book.connect("interacted", play_sound_from_array.bind("book picked up", $Books, book_pickup_array))
	animated_book.connect("turn_page", play_sound_from_array.bind("book interacted", $Books, book_turn_page_array))
	chest_top_collision_1.connect("chest_opened", play_sound_from_array.bind("chest opening", $ChestOpening, chest_open_array))
	chest_top_collision_2.connect("chest_opened", play_sound_from_array.bind("chest opening", $ChestOpening, chest_open_array))
	diary.connect("interacted", play_sound_from_array.bind("diary interacted", $Books, book_turn_page_array))
	item_coal.connect("interacted", play_sound_from_array.bind("item drop", $ItemInteract, item_interact_array))
	item_crucible.connect("interacted", play_sound_from_array.bind("item drop", $ItemInteract, item_interact_array))
	item_fireplace_slot.connect("interacted", play_sound_from_array.bind("item drop", $ItemInteract, item_interact_array))
	item_fireplace_slot.connect("puzzle_molten_coin", play_sound_from_array.bind("molten coin", $Melting, melting_array))
	item_flintandsteel.connect("interacted", play_sound_from_array.bind("item drop", $ItemInteract, item_interact_array))
	item_gravedirt.connect("interacted", play_sound_from_array.bind("item drop", $ItemInteract, item_interact_array))
	item_jarofgrapes.connect("interacted", play_sound_from_array.bind("item drop", $ItemInteract, item_interact_array))
	item_mortar_slot.connect("interacted", play_sound_from_array.bind("item drop", $ItemInteract, item_interact_array))
	item_mortar_slot.connect("puzzle_mortar", play_sound_from_array.bind("mortar crushing", $Mortar, mortar_array))
	item_mushroom.connect("interacted", play_sound_from_array.bind("item drop", $ItemInteract, item_interact_array))
	item_peppergrains.connect("interacted", play_sound_from_array.bind("item drop", $ItemInteract, item_interact_array))
	opal_stone.connect("interacted", play_sound_from_array.bind("item drop", $ItemInteract, item_interact_array))
	player.connect("creepy_event", play_background_music)
	player.connect("player_moved", play_sound_from_array.bind("footstep", $Footsteps, footsteps_array))
	# item_bookblack_salt.connect("interacted", play_sound_from_array.bind("item drop", $ItemInteract, item_interact_array))
	# item_bookblack_surfur.connect("interacted", play_sound_from_array.bind("item drop", $ItemInteract, item_interact_array))
	# item_bookblack_mercury.connect("interacted", play_sound_from_array.bind("item drop", $ItemInteract, item_interact_array))
	# item_bookred_aries.connect("interacted", play_sound_from_array.bind("item drop", $ItemInteract, item_interact_array))
	# item_bookred_taurus.connect("interacted", play_sound_from_array.bind("item drop", $ItemInteract, item_interact_array))
	# item_bookred_gemini.connect("interacted", play_sound_from_array.bind("item drop", $ItemInteract, item_interact_array))
	# item_bookred_cancer.connect("interacted", play_sound_from_array.bind("item drop", $ItemInteract, item_interact_array))
	# item_bookred.connect("interacted", play_sound_from_array.bind("item drop", $ItemInteract, item_interact_array))
	# item_bookred_virgo.connect("interacted", play_sound_from_array.bind("item drop", $ItemInteract, item_interact_array))
	# item_bookred_libra.connect("interacted", play_sound_from_array.bind("item drop", $ItemInteract, item_interact_array))
	# item_bookred_scorpio.connect("interacted", play_sound_from_array.bind("item drop", $ItemInteract, item_interact_array))
	# item_bookred_sagittarius.connect("interacted", play_sound_from_array.bind("item drop", $ItemInteract, item_interact_array))
	# item_bookred_capricorn.connect("interacted", play_sound_from_array.bind("item drop", $ItemInteract, item_interact_array))
	# item_bookred_aquarius.connect("interacted", play_sound_from_array.bind("item drop", $ItemInteract, item_interact_array))
	# item_bookred_projection.connect("interacted", play_sound_from_array.bind("item drop", $ItemInteract, item_interact_array))


	##### Setup randomly timed sounds #####

	setup_randomly_timed_sound($ThunderStorm, $Timers/ThunderStormTimer,
		rand_thunderstorm_time_min_s, rand_thunderstorm_time_max_s, thunderStorm_volume_db,
		on_sound_finished.bind($Timers/ThunderStormTimer, rand_thunderstorm_time_min_s, rand_thunderstorm_time_max_s),
		play_sound_from_array.bind("thunderstorm", $ThunderStorm, thunderstorm_array))

	setup_randomly_timed_sound($Creaks, $Timers/CreaksTimer,
		rand_creak_time_min_s, rand_creak_time_max_s, creak_volume_db,
		on_sound_finished.bind($Timers/CreaksTimer, rand_creak_time_min_s, rand_creak_time_max_s),
		play_sound_from_array.bind("creak", $Creaks, creaks_array))

	setup_randomly_timed_sound($Bucket, $Timers/Bucket,
		rand_bucket_water_drop_time_min_s, rand_bucket_water_drop_time_max_s, bucket_water_drop_volume_db,
		on_sound_finished.bind($Timers/Bucket, rand_bucket_water_drop_time_min_s, rand_bucket_water_drop_time_max_s),
		play_sound_from_array.bind("bucket_water_drop", $Bucket, bucket_water_drops_array))


##### Helper Functions #####

# setup sounds which are governed by a random timer
func setup_randomly_timed_sound(sound_stream, timer, rand_time_min: float, rand_time_max: float, volume: float, callback, sound_to_play):
	sound_stream.volume_db = volume
	sound_stream.connect("finished", callback)
	timer.one_shot = true
	timer.wait_time = generate_random_time(rand_time_min, rand_time_max)
	timer.connect("timeout", sound_to_play)
	timer.start()


# play sound and music
func play_background_music():
	if not $BackgroundMusic.is_playing():
		$BackgroundMusic.play()


# play randomisable sounds from an array of similar sounds
func play_sound_from_array(_sound_name: String, audio_stream, sound_array: Array):
	var random_sound = sound_array[randi() % sound_array.size()]
	audio_stream.stream = random_sound
	audio_stream.play()
	# print("%s played!" %_sound_name) # TODO: debug print


# randomise the timer countdown period between a minimum and maximum value in seconds
func generate_random_time(rand_time_min: float, rand_time_max: float) -> float:
	return randf_range(rand_time_min, rand_time_max)


# restart timers for sound and music
func on_sound_finished(sound_timer: Timer, rand_time_min: float, rand_time_max: float):
	sound_timer.wait_time = generate_random_time(rand_time_min, rand_time_max)
	sound_timer.start()
	# print("%s random time: %f" %[sound_timer.name, sound_timer.wait_time]) # TODO: debug print


##### Play sounds only for the game's intro #####

enum Audio_Players_Names
{
	WALKING = 0,
	DOOR_OPEN,
	DOOR_CLOSE,
	FOUR_STEPS,
	CANDLE_LIGHT
}

func play_intro_sounds():
	# Creates temporary `AudioStreamPlayer`s
	var audio_players: Array = [
		AudioStreamPlayer.new(), # WALKING
		AudioStreamPlayer.new(), # DOOR_OPEN
		AudioStreamPlayer.new(), # DOOR_CLOSE
		AudioStreamPlayer.new(), # FOUR_STEPS
		AudioStreamPlayer.new(), # CANDLE_LIGHT
	]

	# Adding as children is necessary to be able to use the `AudioStreamPlayer`s
	for audio_player in audio_players:
		add_child(audio_player)

	# Assignigng a sound to each `AudioStreamPlayer`
	audio_players[Audio_Players_Names.WALKING].stream = load("res://Assets/Audio/Sound/walking_outside.mp3")
	audio_players[Audio_Players_Names.DOOR_OPEN].stream = load("res://Assets/Audio/Sound/door_open.mp3")
	audio_players[Audio_Players_Names.DOOR_CLOSE].stream = load("res://Assets/Audio/Sound/door_close.mp3")
	audio_players[Audio_Players_Names.FOUR_STEPS].stream = load("res://Assets/Audio/Sound/footsteps_cellar_four.mp3")
	audio_players[Audio_Players_Names.CANDLE_LIGHT].stream = load("res://Assets/Audio/Sound/candle_lighting.mp3")

	# Connecting the `finished` signal of each `AudioStreamPlayer` to the following one
	audio_players[Audio_Players_Names.WALKING].connect("finished", audio_players[Audio_Players_Names.DOOR_OPEN].play)
	audio_players[Audio_Players_Names.DOOR_OPEN].connect("finished", audio_players[Audio_Players_Names.DOOR_CLOSE].play)
	audio_players[Audio_Players_Names.DOOR_CLOSE].connect("finished", audio_players[Audio_Players_Names.FOUR_STEPS].play)
	audio_players[Audio_Players_Names.FOUR_STEPS].connect("finished", audio_players[Audio_Players_Names.CANDLE_LIGHT].play)
	audio_players[Audio_Players_Names.CANDLE_LIGHT].connect("finished", on_all_sounds_finished.bind(audio_players))

	audio_players[Audio_Players_Names.FOUR_STEPS].volume_db = -10

	audio_players[Audio_Players_Names.WALKING].play()

func on_all_sounds_finished(audio_players: Array):
	# Remove no longer used `AudioStreamPlayer`
	for audio_player in audio_players:
		audio_player.queue_free()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
