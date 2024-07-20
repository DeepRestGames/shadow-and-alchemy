extends Prop


@export var puzzle_name: String

signal open_puzzle(puzzle_name)


func _interacted():
	print("Puzzle interaction!")
	
	emit_signal("open_puzzle", puzzle_name)
