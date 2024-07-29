class_name GenericPuzzleSlot
extends PuzzleSlot

signal item_was_interacted
signal puzzle_molten_coin

var currently_dropped_items: Array[InventoryItemData]

var reaction_happening:= false

# Super ugly logic just for puzzle behaviours
@export var crucible_puzzle: Puzzle
var crucible = null
var crucible_coin = null
var crucible_melt = null

@export var pepper_puzzle: Puzzle
@export var salt_puzzle: Puzzle
var mortar_filling = null

@export var keypad_puzzle: Puzzle
var keypad = null
var chest_top_collision = null


func _ready():
	# Super ugly logic just for crucible
	if get_parent() != null and get_parent().name == "Fireplace":
		crucible = $"../Crucible"
		crucible_coin = $"../Crucible/CrucibleCoin"
		crucible_melt = $"../Crucible/MoltenSilver"
	
	# Super ugly logic just for mortar and pestle
	if get_parent() != null and get_parent().name == "MortarPestle":
		mortar_filling = $"../MortarFilling"
	
	# Super ugly logic just for keypad
	if get_parent() != null and get_parent().name == "Keypad":
		keypad = $"../"
		chest_top_collision = $"../../ChestTopCollision"


func item_dropped(item: InventoryItemData):
	item_was_interacted.emit()
	print("GENERIC PUZZLE item_was_interacted") # TODO: debug print
	print("Item " + item.item_name + " dropped in slot!")

	# Super ugly logic just for crucible
	if crucible != null:
		item_dropped_crucible(item)
		return

	if mortar_filling != null:
		item_dropped_mortar(item)
		return
	
	if keypad != null:
		item_dropped_keypad(item)
		return


func item_dropped_crucible(item: InventoryItemData):
	if currently_dropped_items.is_empty():
		if item.item_name == "Crucible":
			crucible.show()
			currently_dropped_items.append(item)

			# Add item to puzzles related to slot
			crucible_puzzle.add_puzzle_item(item)
			InventorySystem.remove_item(item)
		else:
			return
	else:
		if item.item_name == "Silver Coin":
			reaction_happening = true
			currently_dropped_items.append(item)
			InventorySystem.remove_item(item)

			crucible_coin.show()
			await get_tree().create_timer(1.5).timeout
			crucible_coin.hide()
			crucible_melt.show()
			puzzle_molten_coin.emit()
			await get_tree().create_timer(1.5).timeout
			crucible.hide()

			# Add item to puzzles related to slot
			crucible_puzzle.add_puzzle_item(item)
			currently_dropped_items.clear()
			reaction_happening = false


func item_dropped_mortar(item: InventoryItemData):
	if currently_dropped_items.is_empty():
		if item.item_name == "Pepper Grains":
			reaction_happening = true
			currently_dropped_items.append(item)
			InventorySystem.remove_item(item)
			
			mortar_filling.show()
			await get_tree().create_timer(1.5).timeout
			
			pepper_puzzle.add_puzzle_item(item)
			currently_dropped_items.clear()
			mortar_filling.hide()
			
			reaction_happening = false
			return
	
	if item.item_name == "Opal Stone" or item.item_name == "Laurel" or item.item_name == "Bowl of Dirt":
		currently_dropped_items.append(item)
		InventorySystem.remove_item(item)
		mortar_filling.show()
		
		# Add item to puzzles related to slot
		salt_puzzle.add_puzzle_item(item)
		if salt_puzzle.puzzle_solved:
			currently_dropped_items.clear()
			mortar_filling.hide()
			return


func item_dropped_keypad(item: InventoryItemData):
	if item.item_name == "Chest Key":
		# Animation would be nice
		reaction_happening = true
		InventorySystem.remove_item(item)
		
		keypad_puzzle.add_puzzle_item(item)
		keypad.hide()
		chest_top_collision._open()
		
		reaction_happening = false
		return


func item_removed(_item: InventoryItemData):
	pass


func remove_items():
	if reaction_happening:
		return
	
	if crucible != null:
		crucible.hide()
		crucible_puzzle.clear_all()
	
	if mortar_filling != null:
		salt_puzzle.clear_all()
		mortar_filling.hide()
	
	for item in currently_dropped_items:
		InventorySystem.add_item(item)
	currently_dropped_items.clear()
	
	print("Removed items from puzzle!")
