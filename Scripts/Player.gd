extends Node3D

signal startBackgroundMusic

@onready var camera_3d = $Camera3D
var unfocus_pos: Vector3
var unfocused_rot: Vector3

var facing_direction: FacingDirection = FacingDirection.WEST
var player_state: PlayerState = PlayerState.IDLE
var previous_state: PlayerState

const TIME_BETWEEN_MOVEMENTS: float = 0.35
const TIME_BETWEEN_ROTATIONS: float = 0.35

@export var current_navigation_point: NavigationPoint
var next_navigation_point: NavigationPoint

# Movement
enum FacingDirection {
	NORTH,	# 0
	EAST,	# 1
	SOUTH,	# 2
	WEST	# 3
}

# State of the player
enum PlayerState {
	IDLE,		# 0		CAN OPEN DIARY
	MOVING,		# 1
	FOCUSING,	# 2
	INVENTORY,	# 3		CAN OPEN DIARY
	DIARY		# 4
}
@onready var diary = $Diary

@onready var debug_ui = $DEBUG_UI

func _ready():
	diary.hide()

func _process(_delta):
	_process_movement_inputs()
	_process_focus_inputs()
	_process_pause_inputs()
	

	# TODO: experiment to start creepy soundtrack at a scripted moment (in this example, focussing on `NavigationPoint11`)
	if (player_state == PlayerState.FOCUSING) and ("NavigationPoint11" in str(current_navigation_point)):
		startBackgroundMusic.emit()

	# TODO: DEBUG/REMOVE
	debug_ui.text = "STATE: " + str(PlayerState.keys()[player_state])
	debug_ui.text += "\nPOS: " + str(camera_3d.global_position)
	debug_ui.text += "\nROT: " + str(camera_3d.global_position)
	debug_ui.text += "\nCurr nav point: " + str(current_navigation_point)

func _process_pause_inputs():
	if Input.is_action_just_pressed("open_diary"):
		if player_state == PlayerState.DIARY and not diary.animation_player.is_playing():
			player_state = previous_state
			diary.put_away()
			
		elif (player_state == PlayerState.IDLE or player_state == PlayerState.FOCUSING) and not diary.animation_player.is_playing():
			previous_state = player_state
			player_state = PlayerState.DIARY
			diary.pull_out()
	if Input.is_action_just_pressed("turn_diary_left") and player_state == PlayerState.DIARY:
		diary.turn_left()
	if Input.is_action_just_pressed("turn_diary_right") and player_state == PlayerState.DIARY:
		diary.turn_right()

	

func _process_focus_inputs():
	var focus_point: FocusPoint = null

	var match_north = current_navigation_point["north_focus_point"] and facing_direction == FacingDirection.NORTH
	if match_north:
		focus_point = current_navigation_point["north_focus_point"]
	var match_east = current_navigation_point["east_focus_point"] and facing_direction == FacingDirection.EAST
	if match_east:
		focus_point = current_navigation_point["east_focus_point"]
	var match_south = current_navigation_point["south_focus_point"] and facing_direction == FacingDirection.SOUTH
	if match_south:
		focus_point = current_navigation_point["south_focus_point"]
	var match_west = current_navigation_point["west_focus_point"] and facing_direction == FacingDirection.WEST
	if match_west:
		focus_point = current_navigation_point["west_focus_point"]

	if match_north or match_east or match_south or match_west:
		if Input.is_action_just_pressed("move_forward") and player_state == PlayerState.IDLE:
			player_state = PlayerState.MOVING
			unfocus_pos = camera_3d.global_position
			unfocused_rot = camera_3d.global_rotation_degrees
			_animate_focus(focus_point)
		elif Input.is_action_just_pressed("move_backward") and player_state == PlayerState.FOCUSING:
			player_state = PlayerState.MOVING
			_animate_defocus(unfocus_pos, unfocused_rot)

func _process_movement_inputs():
	# --- FORWARD ---
	if Input.is_action_just_pressed("move_forward") and player_state == PlayerState.IDLE:
		# Check if there's a valid navigation point forward
		match facing_direction:

			FacingDirection.NORTH:
				if current_navigation_point.north_navigation_point != null:
					next_navigation_point = current_navigation_point.north_navigation_point
				else:
					_impossible_movement()

			FacingDirection.EAST:
				if current_navigation_point.east_navigation_point != null:
					next_navigation_point = current_navigation_point.east_navigation_point
				else:
					_impossible_movement()

			FacingDirection.SOUTH:
				if current_navigation_point.south_navigation_point != null:
					next_navigation_point = current_navigation_point.south_navigation_point
				else:
					_impossible_movement()

			FacingDirection.WEST:
				if current_navigation_point.west_navigation_point != null:
					next_navigation_point = current_navigation_point.west_navigation_point
				else:
					_impossible_movement()

	# --- BACKWARD ---
	elif Input.is_action_just_pressed("move_backward") and player_state == PlayerState.IDLE:

		# Check if there's a valid navigation point backwards
		match facing_direction:

			FacingDirection.NORTH:
				if current_navigation_point.south_navigation_point != null:
					next_navigation_point = current_navigation_point.south_navigation_point
				else:
					_impossible_movement()

			FacingDirection.EAST:
				if current_navigation_point.west_navigation_point != null:
					next_navigation_point = current_navigation_point.west_navigation_point
				else:
					_impossible_movement()

			FacingDirection.SOUTH:
				if current_navigation_point.north_navigation_point != null:
					next_navigation_point = current_navigation_point.north_navigation_point
				else:
					_impossible_movement()

			FacingDirection.WEST:
				if current_navigation_point.east_navigation_point != null:
					next_navigation_point = current_navigation_point.east_navigation_point
				else:
					_impossible_movement()

	# After direction is established, continue with movement logic
	if next_navigation_point != null:
		_animate_movement(next_navigation_point.global_position)
		current_navigation_point = next_navigation_point
		next_navigation_point = null

	# --- RIGHT ---
	elif Input.is_action_just_pressed("turn_right") and player_state == PlayerState.IDLE:
		# Jump to start of enum
		if facing_direction == FacingDirection.WEST:
			facing_direction = FacingDirection.NORTH
		else:
			facing_direction = facing_direction + 1 as FacingDirection
		var next_face = global_rotation_degrees
		next_face.y -= 90
		_animate_turn(next_face)

	# --- LEFT ---
	elif Input.is_action_just_pressed("turn_left") and player_state == PlayerState.IDLE:
		# Jump to end of enum
		if facing_direction == FacingDirection.NORTH:
			facing_direction = FacingDirection.WEST
		else:
			facing_direction = facing_direction - 1 as FacingDirection
		var next_face = global_rotation_degrees
		next_face.y += 90
		_animate_turn(next_face)

# ------------------ MOVEMENT ANIMATION ------------------
func _animate_movement(next_pos):
	player_state = PlayerState.MOVING
	var tween = get_tree().create_tween()
	tween.connect("finished", _tween_movement_over)
	tween.set_trans(Tween.TRANS_QUAD)
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(self, "global_position", next_pos, TIME_BETWEEN_MOVEMENTS)

func _animate_turn(next_face):
	player_state = PlayerState.MOVING
	var tween = get_tree().create_tween()
	tween.connect("finished", _tween_movement_over)
	tween.set_trans(Tween.TRANS_QUAD)
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(self, "global_rotation_degrees", next_face, TIME_BETWEEN_ROTATIONS)

func _tween_movement_over():
	player_state = PlayerState.IDLE
# --------------------------------------------------------
# ------------------ MOVEMENT FOCUSING ------------------
func _animate_focus(focus_point: FocusPoint):
	var tween = get_tree().create_tween()
	tween.connect("finished", _tween_focus_over)
	tween.set_trans(Tween.TRANS_QUAD)
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.set_parallel(true)
	tween.tween_property(camera_3d, "global_position", focus_point.focus_camera.global_position, TIME_BETWEEN_MOVEMENTS)
	tween.tween_property(camera_3d, "global_rotation_degrees", focus_point.focus_camera.global_rotation_degrees, TIME_BETWEEN_MOVEMENTS)

func _animate_defocus(_unfocus_pos, _unfocused_rot):
	var tween = get_tree().create_tween()
	tween.connect("finished", _tween_defocus_over)
	tween.set_trans(Tween.TRANS_QUAD)
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.set_parallel(true)
	tween.tween_property(camera_3d, "global_position", _unfocus_pos, TIME_BETWEEN_MOVEMENTS)
	tween.tween_property(camera_3d, "global_rotation_degrees", _unfocused_rot, TIME_BETWEEN_MOVEMENTS)

func _tween_focus_over():
	player_state = PlayerState.FOCUSING

func _tween_defocus_over():
	player_state = PlayerState.IDLE
# -------------------------------------------------------
func _impossible_movement():
	# TODO: remove debug message
	print("It's impossible to move forward!")
