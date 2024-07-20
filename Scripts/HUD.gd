extends Control


@onready var combination_puzzle_hud = $CombinationLockPuzzle


func _ready():
	var combination_puzzle_scene = get_node("../../Props/RedBottle")
	combination_puzzle_scene.open_puzzle.connect(show_combination_puzzle)


func show_combination_puzzle(puzzle_name):
	print(puzzle_name)
	
	combination_puzzle_hud.show()
