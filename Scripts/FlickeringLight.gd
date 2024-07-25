extends Node3D


@onready var light = $OmniLight3D

@export var range_max := 0.61
@export var range_min := 0.59

@export var energy_max := 0.42
@export var energy_min := 0.38

@export var change_time_min := 0.4
@export var change_time_max := 0.6

var current_change_time := 0.0


func _process(delta):
	
	current_change_time -= delta
	
	if current_change_time <= 0.0:
		light.omni_range = randf_range(range_min, range_max)
		light.light_energy = randf_range(energy_min, energy_max)
		
		current_change_time = randf_range(change_time_min, change_time_max)
