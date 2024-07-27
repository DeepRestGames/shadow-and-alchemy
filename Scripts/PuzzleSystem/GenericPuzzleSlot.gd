class_name GenericPuzzleSlot
extends PuzzleSlot


@export var related_puzzles: Array[Puzzle]


func item_dropped(item: InventoryItemData):
	("Item " + item.item_name + " dropped in slot!")
	
	if not item.is_reusable:
		print("Can't put this object here!")
	
	# Add item to puzzles related to slot
	for puzzle in related_puzzles:
		puzzle.add_puzzle_item(item)


func item_removed(item: InventoryItemData):
	pass


func remove_items():
	print("Removed items from puzzle!")
	
	for puzzle in related_puzzles:
		puzzle.clear_all()
