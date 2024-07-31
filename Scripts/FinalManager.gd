extends Node3D


signal homunculus_was_created
signal neck_brocken
signal drop_dead

@export var homunculus: PackedScene
@onready var homunculus_spawn_position = $HomunculusSpawnPosition
@onready var path_follow = $HomunculusSpawnPosition/Path3D/PathFollow3D
var move_smoke:= false
var homunculus_created:= false

@export var player: Player
@export var camera: Camera3D
var camera_starting_rotation

@onready var evil_eye: Sprite3D = $HomunculusSpawnPosition/EvilEye
@onready var black_screen: ColorRect = $ColorRect
@onready var credits: RichTextLabel = $Credits
@onready var main_title: TextureRect = $MainTitle


func _ready():
	InventorySystem.last_reward_dropped.connect(spawn_homunculus)
	player.focus_window.connect(ending_scene)


func _process(delta):
	if move_smoke:
		path_follow.progress_ratio = lerp(path_follow.progress_ratio, 1.0, delta * 0.3)
		camera.look_at(path_follow.global_position)
		
		if path_follow.progress_ratio >= .9:
			move_smoke = false
			
			var tween = create_tween().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_SINE)
			tween.tween_property(camera, "rotation", camera_starting_rotation, 2.5)
			await tween.finished
			
			player.playing_intro = false


func spawn_homunculus():
	homunculus_created = true
	player.playing_intro = true
	camera_starting_rotation = camera.rotation
	Input.mouse_mode = Input.MOUSE_MODE_HIDDEN
	player.inventory_ui.close_inventory()
	
	var homunculus_instance = homunculus.instantiate()
	path_follow.add_child(homunculus_instance)
	homunculus_instance.global_position = homunculus_spawn_position.global_position
	homunculus_was_created.emit()
	
	await get_tree().create_timer(1.5).timeout
	move_smoke = true


func ending_scene():
	if not homunculus_created:
		return
	
	player.playing_intro = true
	
	var tween = create_tween().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_SINE)
	tween.tween_interval(1.5)
	tween.chain().tween_property(evil_eye, "modulate", Color.WHITE, 3)
	tween.chain().tween_interval(1.5)
	tween.chain().tween_property(camera, "rotation", Vector3(0, -5, 0), .2)
	await tween.finished
	neck_brocken.emit()
	
	tween = create_tween().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_SINE)
	tween.chain().tween_interval(.5)
	tween.chain().tween_property(camera, "position", Vector3(0, -0.8, 0.7), 1.5)
	tween.parallel().tween_property(camera, "rotation", Vector3(2, 0, 0), 1.5)
	await tween.finished
	drop_dead.emit()
	
	tween = create_tween().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_SINE)
	tween.chain().tween_interval(1.5)
	tween.chain().tween_property(black_screen, "color", Color.BLACK, 2.5)
	tween.chain().tween_interval(2.5)
	tween.chain().tween_property(main_title, "modulate", Color.WHITE, 1.5)
	tween.chain().tween_interval(5)
	tween.chain().tween_property(main_title, "modulate", Color.TRANSPARENT, 1.5)
	tween.chain().tween_interval(2.5)
	tween.chain().tween_property(credits, "modulate", Color.WHITE, 1.5)
	tween.chain().tween_interval(8)
	tween.chain().tween_property(credits, "modulate", Color.TRANSPARENT, 1.5)
	tween.chain().tween_interval(2.5)
	
	await tween.finished
	get_tree().quit()
	
