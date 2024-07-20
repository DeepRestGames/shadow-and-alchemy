extends Node3D


var viewport: Viewport
var camera: Camera3D
var space_state: PhysicsDirectSpaceState3D

@export var props_collision_layer := 2
@export var ray_lenght: float

var current_intersected_prop: Prop


func _ready():
	viewport = get_viewport()
	camera = viewport.get_camera_3d()
	space_state = get_world_3d().direct_space_state
	ray_lenght = camera.far


func _input(event):
	
	if event is InputEventMouseMotion:
		var mouse_position := viewport.get_mouse_position()
		
		var origin := camera.project_ray_origin(mouse_position)
		var direction := camera.project_ray_normal(mouse_position)

		var end := origin + direction * ray_lenght
		
		var query := PhysicsRayQueryParameters3D.create(origin, end, props_collision_layer)
		var result := space_state.intersect_ray(query)
		
		if not result.is_empty():
			current_intersected_prop = result["collider"] as Prop
		else:
			current_intersected_prop = null


func _process(_delta):
	
	if Input.is_action_just_pressed("left_click") and current_intersected_prop != null:
		current_intersected_prop._interacted()

