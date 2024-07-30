class_name Puzzle
extends Resource

signal item_was_interacted

@export var puzzle_name: String
@export_multiline var puzzle_description: String

var current_puzzle_items: Array
@export var puzzle_solution_items: Array
@export var order_needed: bool

@export var reward: InventoryItemData
var puzzle_solved := false

@export var alchemical_process_needed := false
@export var alchemical_process_solution: AlchemicalProcessSymbol.AlchemicalProcesses
var current_alchemical_process: AlchemicalProcessSymbol.AlchemicalProcesses


func add_puzzle_item(item: InventoryItemData):
	if puzzle_solved:
		return

	current_puzzle_items.append(item)

	print("Added puzzle item " + item.item_name)

	check_puzzle_solution()


func remove_puzzle_item(item: InventoryItemData):
	item_was_interacted.emit()
	if puzzle_solved:
		return

	print("Removed puzzle item " + item.item_name)

	current_puzzle_items.erase(item)


func clear_all():
	if puzzle_solved:
		return

	print("Clear puzzles")

	current_puzzle_items.clear()


func change_alchemical_process(process: AlchemicalProcessSymbol.AlchemicalProcesses):
	if puzzle_solved:
		return

	current_alchemical_process = process
	check_puzzle_solution()


func check_puzzle_solution():
	if puzzle_solved:
		return

	# Check if all solution items are present
	var missing_puzzle_item = false
	for puzzle_item in puzzle_solution_items:
		if !current_puzzle_items.has(puzzle_item):
			missing_puzzle_item = true
	if not missing_puzzle_item:
		if alchemical_process_needed:
			if current_alchemical_process == alchemical_process_solution:
				print("Puzzle solved!")
				InventorySystem.add_item(reward)
				puzzle_solved = true
		else:
			print("Puzzle solved!")
			if reward != null:
				InventorySystem.add_item(reward)
			puzzle_solved = true

