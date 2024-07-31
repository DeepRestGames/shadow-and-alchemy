extends Node

##### Preload sounds to randomise their execution later #####

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

const bucket_water_drops_array = [
	preload("res://Assets/Audio/Sound/water_drop_1.mp3"),
	preload("res://Assets/Audio/Sound/water_drop_2.mp3"),
	preload("res://Assets/Audio/Sound/water_drop_3.mp3"),
	preload("res://Assets/Audio/Sound/water_drop_4.mp3"),
	preload("res://Assets/Audio/Sound/water_drop_5.mp3"),
	preload("res://Assets/Audio/Sound/water_drop_6.mp3"),
]

const chest_open_array = [preload("res://Assets/Audio/Sound/chest_opening_short.mp3")]

const coin_array = [preload("res://Assets/Audio/Sound/silver_coin.mp3")]

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

const melting_array = [preload("res://Assets/Audio/Sound/melting.mp3")]

const mortar_array = [
	preload("res://Assets/Audio/Sound/crushing_new_1.mp3"),
	preload("res://Assets/Audio/Sound/crushing_new_2.mp3"),
]

const object_interaction_array = [
	preload("res://Assets/Audio/Sound/drop_1.mp3"),
	preload("res://Assets/Audio/Sound/drop_2.mp3"),
	preload("res://Assets/Audio/Sound/drop_3.mp3"),
	preload("res://Assets/Audio/Sound/drop_4.mp3"),
	preload("res://Assets/Audio/Sound/drop_5.mp3"),
	preload("res://Assets/Audio/Sound/drop_6.mp3"),
]

const thunderstorm_array = [preload("res://Assets/Audio/Sound/storm_faded.mp3")]

const water_flask_array = [preload("res://Assets/Audio/Sound/bottle_open.mp3")]

# Called when the node enters the scene tree for the first time.
func _ready():
	# print("Audio scene loaded") # TODO: debug print
	play_intro_sounds() # TODO: enable where and when required

	##### Nodes required to connect signals #####

	var alchemical_circle_1 = get_node("../Props/AlchemicalCircle/AlchemicalCirclePuzzleSlot1")
	var alchemical_circle_2 = get_node("../Props/AlchemicalCircle/AlchemicalCirclePuzzleSlot2")
	var alchemical_circle_3 = get_node("../Props/AlchemicalCircle/AlchemicalCirclePuzzleSlot3")
	var animated_book = get_node("../Player/AnimatedBook")
	var chest_top_collision_1: Node = get_node("../Chests/ChestTop/ChestTopCollision")
	var chest_top_collision_2: Node = get_node("../Props/BloodChest/ChestTop/ChestTopCollision")
	var coal = get_node("../Props/ItemCoal")
	var coin = get_node("../Props/CoinPurse/ItemSilverCoin")
	var crucible = get_node("../Props/ItemCrucible")
	var diary = get_node("../Player/Diary")
	var fireplace_slot = get_node("../Props/Fireplace/GenericPuzzleSlot")
	var gravedirt = get_node("../Props/GraveDirt/ItemBowlOfDirt")
	var jarofgrapes = get_node("../Props/ItemJarOfGrapes")
	var mortar_slot = get_node("../Props/MortarPestle/GenericPuzzleSlot")
	var mushroom = get_node("../Props/ItemMushroom")
	var opal_stone = get_node("../Props/Hand3/ItemOpalStone")
	var peppergrains = get_node("../Props/ItemPepperGrains")
	var player: Node = get_node("../Player")
	var water_flask = get_node("../Props/Bucket/ItemWaterFlask")
	var final_manager = get_node("../FinalManager")
	# var bookblack_mercury = get_node("../Props/ItemBookBlack_Mercury")
	# var bookblack_salt = get_node("../Props/ItemBookBlack_Salt")
	# var bookblack_surfur = get_node("../Props/ItemBookBlack_Surfur")
	# var bookred = get_node("../Props/ItemBookRed-Leo")
	# var bookred_aquarius = get_node("../Props/ItemBookRed_Aquarius")
	# var bookred_aries = get_node("../Props/ItemBookRed_Aries")
	# var bookred_cancer = get_node("../Props/ItemBookRed_Cancer")
	# var bookred_capricorn = get_node("../Props/ItemBookRed_Capricorn")
	# var bookred_gemini = get_node("../Props/ItemBookRed_Gemini")
	# var bookred_libra = get_node("../Props/ItemBookRed_Libra")
	# var bookred_projection = get_node("../Props/ItemBookRed_Projection")
	# var bookred_sagittarius = get_node("../Props/ItemBookRed_Sagittarius")
	# var bookred_scorpio = get_node("../Props/ItemBookRed_Scorpio")
	# var bookred_taurus = get_node("../Props/ItemBookRed_Taurus")
	# var bookred_virgo = get_node("../Props/ItemBookRed_Virgo")


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
	$BackgroundMusic.volume_db = -10
	$HomunculusSFX.volume_db = -15
	$Bucket.attenuation_model = $Bucket.ATTENUATION_INVERSE_SQUARE_DISTANCE
	$Bucket.unit_size = 4
	$Bucket.volume_db = -15
	$ChestOpening.volume_db = -5
	$Fireplace.attenuation_model = $Fireplace.ATTENUATION_INVERSE_SQUARE_DISTANCE
	$Fireplace.volume_db = -15
	$Footsteps.volume_db = -15
	$ItemInteract.volume_db = -5
	$Mortar.volume_db = -10
	$WaterFlask.volume_db = -10
	$BrokenNeck.volume_db = -10
	$DropDead.volume_db = -5

	##### Setup background music #####

	var background_music: AudioStreamMP3 = $BackgroundMusic.stream as AudioStreamMP3
	background_music.loop = false
	# background_music.loop_offset = 21.333 # measures 9 to 16 included

	var homunculus_music: AudioStreamMP3 = $HomunculusSFX.stream as AudioStreamMP3

	##### Setup interaction sounds (connections) #####

	alchemical_circle_1.connect("interacted", play_sound_from_array.bind("item drop", $ItemInteract, object_interaction_array))
	alchemical_circle_2.connect("interacted", play_sound_from_array.bind("item drop", $ItemInteract, object_interaction_array))
	alchemical_circle_3.connect("interacted", play_sound_from_array.bind("item drop", $ItemInteract, object_interaction_array))
	animated_book.connect("interacted", play_sound_from_array.bind("book picked up", $Books, book_pickup_array))
	animated_book.connect("turn_page", play_sound_from_array.bind("book interacted", $Books, book_turn_page_array))
	coin.connect("coin_purse", play_sound_from_array.bind("coin", $WaterFlask, coin_array))
	water_flask.connect("water_flask", play_sound_from_array.bind("water flask", $WaterFlask, water_flask_array))
	chest_top_collision_1.connect("chest_opened", play_sound_from_array.bind("chest opening", $ChestOpening, chest_open_array))
	chest_top_collision_2.connect("chest_opened", play_sound_from_array.bind("chest opening", $ChestOpening, chest_open_array))
	diary.connect("interacted", play_sound_from_array.bind("diary interacted", $Books, book_turn_page_array))
	coal.connect("interacted", play_sound_from_array.bind("item drop", $ItemInteract, object_interaction_array))
	crucible.connect("interacted", play_sound_from_array.bind("item drop", $ItemInteract, object_interaction_array))
	fireplace_slot.connect("interacted", play_sound_from_array.bind("item drop", $ItemInteract, object_interaction_array))
	fireplace_slot.connect("puzzle_molten_coin", play_sound_from_array.bind("molten coin", $Melting, melting_array))
	gravedirt.connect("interacted", play_sound_from_array.bind("item drop", $ItemInteract, object_interaction_array))
	jarofgrapes.connect("interacted", play_sound_from_array.bind("item drop", $ItemInteract, object_interaction_array))
	mortar_slot.connect("interacted", play_sound_from_array.bind("item drop", $ItemInteract, object_interaction_array))
	mortar_slot.connect("puzzle_mortar", play_sound_from_array.bind("mortar crushing", $Mortar, mortar_array))
	mushroom.connect("interacted", play_sound_from_array.bind("item drop", $ItemInteract, object_interaction_array))
	peppergrains.connect("interacted", play_sound_from_array.bind("item drop", $ItemInteract, object_interaction_array))
	opal_stone.connect("interacted", play_sound_from_array.bind("item drop", $ItemInteract, object_interaction_array))
	player.connect("creepy_event", play_background_music)
	player.connect("player_moved", play_sound_from_array.bind("footstep", $Footsteps, footsteps_array))
	final_manager.connect("homunculus_was_created", play_homunculus_music)
	final_manager.connect("neck_brocken", play_broken_neck)
	final_manager.connect("drop_dead", play_drop_dead)
	# bookblack_salt.connect("interacted", play_sound_from_array.bind("item drop", $ItemInteract, object_interaction_array))
	# bookblack_surfur.connect("interacted", play_sound_from_array.bind("item drop", $ItemInteract, object_interaction_array))
	# bookblack_mercury.connect("interacted", play_sound_from_array.bind("item drop", $ItemInteract, object_interaction_array))
	# bookred_aries.connect("interacted", play_sound_from_array.bind("item drop", $ItemInteract, object_interaction_array))
	# bookred_taurus.connect("interacted", play_sound_from_array.bind("item drop", $ItemInteract, object_interaction_array))
	# bookred_gemini.connect("interacted", play_sound_from_array.bind("item drop", $ItemInteract, object_interaction_array))
	# bookred_cancer.connect("interacted", play_sound_from_array.bind("item drop", $ItemInteract, object_interaction_array))
	# bookred.connect("interacted", play_sound_from_array.bind("item drop", $ItemInteract, object_interaction_array))
	# bookred_virgo.connect("interacted", play_sound_from_array.bind("item drop", $ItemInteract, object_interaction_array))
	# bookred_libra.connect("interacted", play_sound_from_array.bind("item drop", $ItemInteract, object_interaction_array))
	# bookred_scorpio.connect("interacted", play_sound_from_array.bind("item drop", $ItemInteract, object_interaction_array))
	# bookred_sagittarius.connect("interacted", play_sound_from_array.bind("item drop", $ItemInteract, object_interaction_array))
	# bookred_capricorn.connect("interacted", play_sound_from_array.bind("item drop", $ItemInteract, object_interaction_array))
	# bookred_aquarius.connect("interacted", play_sound_from_array.bind("item drop", $ItemInteract, object_interaction_array))
	# bookred_projection.connect("interacted", play_sound_from_array.bind("item drop", $ItemInteract, object_interaction_array))


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


func play_homunculus_music():
	if not $HomunculusSFX.is_playing():
		$HomunculusSFX.play()


func play_broken_neck():
	$BrokenNeck.play()
	$BackgroundMusic.stop()
	$HomunculusSFX.stop()


func play_drop_dead():
	$DropDead.play()


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
