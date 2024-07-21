extends Node3D

# Movement
enum FacingDirection {
	NORTH,	# 0
	EAST,	# 1
	SOUTH,	# 2
	WEST	# 3
}

var facing_direction = FacingDirection.WEST
@export var current_navigation_point: NavigationPoint
var next_navigation_point: NavigationPoint


func _process(_delta):
	if Input.is_action_just_pressed("move_forward"):
		
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
	
	
	elif Input.is_action_just_pressed("move_backward"):
		
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
		self.position = next_navigation_point.position
		
		current_navigation_point = next_navigation_point
		next_navigation_point = null
	
	
	elif Input.is_action_just_pressed("turn_right"):
		if facing_direction == FacingDirection.WEST:
			facing_direction = FacingDirection.NORTH
		else:
			facing_direction += 1
		global_rotation_degrees.y -= 90	
	
	elif Input.is_action_just_pressed("turn_left"):
		if facing_direction == FacingDirection.NORTH:
			facing_direction = FacingDirection.WEST
		else:
			facing_direction -= 1
		global_rotation_degrees.y += 90	
		


func _impossible_movement():
	# TODO: remove debug message
	print("It's impossible to move forward!")
