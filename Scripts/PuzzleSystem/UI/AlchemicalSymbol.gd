extends Control


@onready var process_icon = $ProcessIcon
@onready var alchemical_process_symbol = $"../.."

@export var process_name: AlchemicalProcessSymbol.AlchemicalProcesses
@export var process_texture: Texture2D


func _ready():
	process_icon.texture = process_texture


func _on_button_pressed():
	alchemical_process_symbol.new_process_chosen(process_icon.texture)
