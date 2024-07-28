class_name AlchemicalCirclePuzzleSlot
extends PuzzleSlot


@onready var alchemical_circle = $".."

@onready var item_spawn_origin = $ItemSpawnOrigin
var current_dropped_item: InventoryItemData
var current_dropped_item_scene = null
var current_prop_pickup_scene: Prop_Pickup = null

signal item_was_interacted

func item_dropped(item: InventoryItemData):
	item_was_interacted.emit()
	# print("ALCHEMICAL CIRCLE item_was_interacted") # TODO: debug print

	# Swap dropped item with already present one
	if current_dropped_item != null:
		var pickup_scene_to_remove = null
		if current_dropped_item_scene is Prop_Pickup:
			pickup_scene_to_remove._interacted()
		else:
			for node in current_dropped_item_scene.get_children(true):
				if node is Prop_Pickup:
					pickup_scene_to_remove = node as Prop_Pickup
					pickup_scene_to_remove._interacted()
					break

	print("Item " + item.item_name + " dropped in slot!")
	current_dropped_item = item

	# Instantiate item 3D model on top of current puzzle slot
	var item_scene = load(item.item_model_scene_path)
	var item_scene_instance = item_scene.instantiate()
	get_tree().root.add_child(item_scene_instance)
	item_scene_instance.global_position = item_spawn_origin.global_position

	# Get node in model scene with Prop_Pickup script
	if item_scene_instance is Prop_Pickup:
		current_prop_pickup_scene = item_scene_instance
	else:
		for node in item_scene_instance.get_children(true):
			if node is Prop_Pickup:
				current_prop_pickup_scene = node as Prop_Pickup
				break
	item_scene_instance.global_position.y += current_prop_pickup_scene.item_model_height / 2
	current_dropped_item_scene = item_scene_instance
	current_prop_pickup_scene.dropped_in_puzzle_slot = self

	# Add item to puzzles related to slot
	for puzzle in alchemical_circle.related_puzzles:
		puzzle.add_puzzle_item(item)

	# Remove from inventory if item is not reusable
	if not current_dropped_item.is_reusable:
		InventorySystem.remove_item(current_dropped_item)


func item_removed(item: InventoryItemData):
	item_was_interacted.emit()
	print("Item " + item.item_name + " removed from slot!")

	# Remove item from puzzles related to slot
	for puzzle in alchemical_circle.related_puzzles:
		puzzle.remove_puzzle_item(item)

	current_dropped_item = null
	current_dropped_item_scene = null
	current_prop_pickup_scene = null
