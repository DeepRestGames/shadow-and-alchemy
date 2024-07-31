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


@onready var alchemical_circle = $".."
@onready var process_icon = $ProcessIcon
@onready var alchemical_symbols_choice = $AlchemicalSymbolsChoice

var selected_alchemical_process := AlchemicalProcesses.MULTIPLICATION


func _ready():
	alchemical_symbols_choice.hide()


func _interacted():
	if alchemical_symbols_choice.is_visible_in_tree():
		alchemical_symbols_choice.hide()
		InteractionSystem.alchemical_process_choice_closed.emit()
	else:
		alchemical_symbols_choice.show()
		InteractionSystem.alchemical_process_choice_opened.emit()
	


func new_process_chosen(process: AlchemicalProcesses, icon: Texture2D):
	selected_alchemical_process = process
	process_icon.texture = icon
	
	# Add item to puzzles related to slot
	for puzzle in alchemical_circle.related_puzzles:
		puzzle.change_alchemical_process(selected_alchemical_process)
	
	alchemical_symbols_choice.hide()
	InteractionSystem.alchemical_process_choice_closed.emit()
