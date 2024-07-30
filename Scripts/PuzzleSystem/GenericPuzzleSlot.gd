class_name GenericPuzzleSlot
extends PuzzleSlot

signal item_was_interacted
signal puzzle_molten_coin

@export var related_puzzles: Array[Puzzle]
var currently_dropped_items: Array[InventoryItemData]

@export var model_variation: Node3D

# Super ugly logic just for crucible
var crucible = null
var crucible_coin = null
var crucible_melt = null


func _ready():
	# Super ugly logic just for crucible
	if get_parent() != null and get_parent().name == "Fireplace":
		crucible = $"../Crucible"
		crucible_coin = $"../Crucible/CrucibleCoin"
		crucible_melt = $"../Crucible/MoltenSilver"


func item_dropped(item: InventoryItemData):
	item_was_interacted.emit()
	print("GENERIC PUZZLE item_was_interacted") # TODO: debug print
	print("Item " + item.item_name + " dropped in slot!")


	# Super ugly logic just for crucible
	if crucible != null:
		if currently_dropped_items.is_empty():
			if item.item_name == "Crucible":
				crucible.show()
			else:
				return

		else:
			if item.item_name == "Silver Coin":
				crucible_coin.show()
				await get_tree().create_timer(1.5).timeout
				crucible_coin.hide()
				crucible_melt.show()
				puzzle_molten_coin.emit()
				await get_tree().create_timer(1.5).timeout
				crucible.hide()


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
