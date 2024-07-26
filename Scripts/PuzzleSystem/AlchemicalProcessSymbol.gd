class_name AlchemicalProcessSymbol
extends Prop


enum AlchemicalProcesses {
	CALCINATION,
	CONGELATION,
	FIXATION,
	SOLUTION,
	DIGESTION,
	DISTILLATION,
	SUBLIMATION,
	SEPARATION,
	CERATION,
	FERMENTATION,
	MULTIPLICATION,
	PROJECTION
}


@onready var process_icon = $ProcessIcon
@onready var alchemical_symbols_choice = $AlchemicalSymbolsChoice


func _ready():
	alchemical_symbols_choice.hide()


func _interacted():
	alchemical_symbols_choice.show()


func new_process_chosen(icon: Texture2D):
	process_icon.texture = icon
	alchemical_symbols_choice.hide()
