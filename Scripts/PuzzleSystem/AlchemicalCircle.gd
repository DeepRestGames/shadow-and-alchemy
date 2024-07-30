extends Node3D


@export var related_puzzles: Array[Puzzle]
@export var puzzle_slots: Array[AlchemicalCirclePuzzleSlot]


func _ready():
	for puzzle in related_puzzles:
		puzzle.puzzle_just_solved.connect(puzzle_solved)


func puzzle_solved(puzzle):
	var solved_puzzle = puzzle as Puzzle
	
	for item in solved_puzzle.puzzle_solution_items:
		# Remove item from puzzle slots
		for slot in puzzle_slots:
			if slot.current_dropped_item == item:
				slot.erase_used_item()
				break
		
		# Remove item from Inventory
		InventorySystem.remove_item(item)
