class_name GenericPuzzleSlot
extends PuzzleSlot

signal item_was_dropped

@export var related_puzzles: Array[Puzzle]
var currently_dropped_items: Array[InventoryItemData]

@export var model_variation: Node3D


func item_dropped(item: InventoryItemData):
	item_was_dropped.emit()
	print("GENERIC PUZZLE item_was_dropped") # TODO: debug print
	print("Item " + item.item_name + " dropped in slot!")
	
	currently_dropped_items.append(item)
	
	# Add item to puzzles related to slot
	for puzzle in related_puzzles:
		puzzle.add_puzzle_item(item)
	
	InventorySystem.remove_item(item)
	
	if model_variation != null:
		model_variation.show()


func item_removed(_item: InventoryItemData):
	pass


func remove_items():
	print("Removed items from puzzle!")
	
	for item in currently_dropped_items:
		InventorySystem.add_item(item)
	currently_dropped_items.clear()
	
	for puzzle in related_puzzles:
		puzzle.clear_all()
	
	if model_variation != null:
		model_variation.hide()
