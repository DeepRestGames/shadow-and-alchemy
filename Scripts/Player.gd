extends Node3D

# Movement
enum FacingDirection {
	NORTH,
	EAST,
	SOUTH,
	WEST
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
		
		match facing_direction:
			
			FacingDirection.NORTH:
				facing_direction = FacingDirection.EAST
				global_rotation_degrees.y = -90
			
			FacingDirection.EAST:
				facing_direction = FacingDirection.SOUTH
				global_rotation_degrees.y = -180
			
			FacingDirection.SOUTH:
				facing_direction = FacingDirection.WEST
				global_rotation_degrees.y = -270
			
			FacingDirection.WEST:
				facing_direction = FacingDirection.NORTH
				global_rotation_degrees.y = 0
	
	
	elif Input.is_action_just_pressed("turn_left"):
		
		match facing_direction:
			
			FacingDirection.NORTH:
				facing_direction = FacingDirection.WEST
				global_rotation_degrees.y = -270
			
			FacingDirection.EAST:
				facing_direction = FacingDirection.NORTH
				global_rotation_degrees.y = 0
			
			FacingDirection.SOUTH:
				facing_direction = FacingDirection.EAST
				global_rotation_degrees.y = -90
			
			FacingDirection.WEST:
				facing_direction = FacingDirection.SOUTH
				global_rotation_degrees.y = -180


func _impossible_movement():
	print("It's impossible to move forward!")
