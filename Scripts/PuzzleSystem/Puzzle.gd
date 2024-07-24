class_name Puzzle
extends Resource


@export var puzzle_name: String
@export_multiline var puzzle_description: String

var current_puzzle_items: Array
@export var puzzle_solution_items: Array
@export var order_needed: bool

@export var reward: InventoryItemData


func add_puzzle_item(item: InventoryItemData):
	current_puzzle_items.append(item)
	
	print("Added puzzle item " + item.item_name)
	
	if current_puzzle_items.all(func(puzzle_item): return puzzle_solution_items.has(puzzle_item)):
		print("Puzzle solved!")


func remove_puzzle_item(item: InventoryItemData):
	print("Removed puzzle item " + item.item_name)
	
	current_puzzle_items.erase(item)