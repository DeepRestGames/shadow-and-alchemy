extends Node3D

var facing_direction = FacingDirection.WEST
var player_state = PlayerState.IDLE

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
	IDLE,		# 0
	MOVING,		# 1
	FOCUSING,	# 2
	INVENTORY	# 3
}

func _animate_movement(next_pos):
	player_state = PlayerState.MOVING
	var tween = get_tree().create_tween()
	tween.connect("finished", _tween_movement_over)
	tween.set_trans(Tween.TRANS_QUAD)
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(self, "position", next_pos, TIME_BETWEEN_MOVEMENTS)
	
func _animate_turn(next_face):
	player_state = PlayerState.MOVING
	var tween = get_tree().create_tween()
	tween.connect("finished", _tween_movement_over)
	tween.set_trans(Tween.TRANS_QUAD)
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(self, "global_rotation_degrees", next_face, TIME_BETWEEN_ROTATIONS)
	
func _tween_movement_over():
	player_state = PlayerState.IDLE


func _process(_delta):
	_process_movement_inputs()

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
		_animate_movement(next_navigation_point.position)
		#self.position = next_navigation_point.position
		
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
	

func _impossible_movement():
	# TODO: remove debug message
	print("It's impossible to move forward!")
