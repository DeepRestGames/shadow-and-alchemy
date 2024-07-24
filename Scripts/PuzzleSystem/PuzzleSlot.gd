class_name PuzzleSlot
extends Node3D


@export var related_puzzles: Array[Puzzle]
@onready var item_spawn_origin = $ItemSpawnOrigin


func item_dropped(item: InventoryItemData):
	print("Item " + item.item_name + " dropped in slot!")
	
	# Instantiate item 3D model on top of current puzzle slot
	var item_scene = load(item.item_model_scene_path)
	var item_scene_instance = item_scene.instantiate()
	get_tree().root.add_child(item_scene_instance)
	item_scene_instance.global_position = item_spawn_origin.global_position
	item_scene_instance.global_position.y += item.item_model_height / 2
	
	# Add item to puzzles related to slot
	for puzzle in related_puzzles:
		puzzle.add_puzzle_item(item)


func item_removed(item: InventoryItemData):
	print("Item " + item.item_name + " removed from slot!")
	
	# Remove item from puzzles related to slot
	for puzzle in related_puzzles:
		puzzle.remove_puzzle_item(item)
