class_name PuzzleSlot
extends Node3D


#@export var related_puzzles: Array[Puzzle]

@onready var alchemical_circle = $".."

@onready var item_spawn_origin = $ItemSpawnOrigin
var current_dropped_item: InventoryItemData
var current_dropped_item_scene = null


func item_dropped(item: InventoryItemData):
	# Swap dropped item with already present one
	if current_dropped_item != null:
		InventorySystem.add_item(current_dropped_item)
		current_dropped_item_scene.queue_free()
		
		item_removed(current_dropped_item)
	
	print("Item " + item.item_name + " dropped in slot!")
	current_dropped_item = item
	
	# Instantiate item 3D model on top of current puzzle slot
	var item_scene = load(item.item_model_scene_path)
	var item_scene_instance = item_scene.instantiate()
	get_tree().root.add_child(item_scene_instance)
	item_scene_instance.global_position = item_spawn_origin.global_position
	
	# Get node in model scene with Prop_Pickup script
	var pickup_item_scene = null
	if item_scene_instance is Prop_Pickup:
		pickup_item_scene = item_scene_instance
	else:
		for node in item_scene_instance.get_children(true):
			if node is Prop_Pickup:
				pickup_item_scene = node as Prop_Pickup
				break
	item_scene_instance.global_position.y += pickup_item_scene.item_model_height / 2
	current_dropped_item_scene = item_scene_instance
	
	# Add item to puzzles related to slot
	for puzzle in alchemical_circle.related_puzzles:
		puzzle.add_puzzle_item(item)


func _process(_delta):
	if current_dropped_item != null and current_dropped_item_scene.is_queued_for_deletion():
		item_removed(current_dropped_item)


func item_removed(item: InventoryItemData):
	print("Item " + item.item_name + " removed from slot!")
	
	# Remove item from puzzles related to slot
	for puzzle in alchemical_circle.related_puzzles:
		puzzle.remove_puzzle_item(item)
	
	current_dropped_item = null
	current_dropped_item_scene = null
