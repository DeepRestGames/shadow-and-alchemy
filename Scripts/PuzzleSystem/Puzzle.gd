class_name Puzzle
extends Resource


@export var puzzle_name: String
@export_multiline var puzzle_description: String

var current_puzzle_items: Array
@export var puzzle_solution_items: Array
@export var order_needed: bool

@export var reward: InventoryItemData
var puzzle_solved := false


func add_puzzle_item(item: InventoryItemData):
	if puzzle_solved:
		return
	
	current_puzzle_items.append(item)
	
	print("Added puzzle item " + item.item_name)
	
	# Check if all solution items are present
	var missing_puzzle_item = false
	for puzzle_item in puzzle_solution_items:
		if !current_puzzle_items.has(puzzle_item):
			missing_puzzle_item = true
	if not missing_puzzle_item:
		print("Puzzle solved!")
		InventorySystem.add_item(reward)
		puzzle_solved = true


func remove_puzzle_item(item: InventoryItemData):
	if puzzle_solved:
		return
	
	print("Removed puzzle item " + item.item_name)
	
	current_puzzle_items.erase(item)
