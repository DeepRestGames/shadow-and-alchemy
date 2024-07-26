class_name AlchemicalProcessSymbol
extends Prop


@onready var process_icon = $ProcessIcon
@onready var alchemical_symbols_choice = $AlchemicalSymbolsChoice


func _interacted():
	print("Alchemical process interacted!")
