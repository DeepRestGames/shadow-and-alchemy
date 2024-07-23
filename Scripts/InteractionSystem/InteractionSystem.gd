extends Node3D


var viewport: Viewport
var camera: Camera3D
var space_state: PhysicsDirectSpaceState3D

@export_range(.5, 5) var ray_lenght: float = 2.5
var ray_origin
var ray_end

# Props interactions
@export var props_collision_layer := 2
var current_intersected_prop: Prop

# Puzzle interactions
@export var puzzle_slots_collision_layer := 4
var is_dragging_item := false
var dragged_item_data = null
var current_intersected_puzzle_slot: PuzzleSlot


func _ready():
	viewport = get_viewport()
	camera = viewport.get_camera_3d()
	space_state = get_world_3d().direct_space_state


func _input(event):
	if event is InputEventMouseMotion:
		# Cast a ray 3D to current mouse position
		var mouse_position := viewport.get_mouse_position()
		
		ray_origin = camera.project_ray_origin(mouse_position)
		var direction := camera.project_ray_normal(mouse_position)
		ray_end = ray_origin + direction * ray_lenght


func _process(_delta):
	
	if Input.is_action_just_pressed("left_click"):
		# Check collisions with props
		var props_collision_query := PhysicsRayQueryParameters3D.create(ray_origin, ray_end, props_collision_layer)
		var props_collision_result := space_state.intersect_ray(props_collision_query)
		
		if not props_collision_result.is_empty():
			current_intersected_prop = props_collision_result["collider"] as Prop
			
			if current_intersected_prop != null:
				current_intersected_prop._interacted()
		
	
	if is_dragging_item and Input.is_action_just_released("left_click"):
		# Check collisions with puzzle slots
		var puzzle_slots_collision_query := PhysicsRayQueryParameters3D.create(ray_origin, ray_end, puzzle_slots_collision_layer)
		var puzzle_slots_collision_result := space_state.intersect_ray(puzzle_slots_collision_query)
		
		if not puzzle_slots_collision_result.is_empty():
			current_intersected_puzzle_slot = puzzle_slots_collision_result["collider"] as PuzzleSlot
			
			if current_intersected_puzzle_slot != null:
				current_intersected_puzzle_slot.item_dropped(dragged_item_data)
		
		is_dragging_item = false
		dragged_item_data = null
	
	current_intersected_prop = null
	current_intersected_puzzle_slot = null

