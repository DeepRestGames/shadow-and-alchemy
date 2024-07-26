extends Control


@onready var process_icon = $ProcessIcon

@export var process_name: AlchemicalSymbolsChoice.AlchemicalProcesses
@export var process_texture: Texture2D


func _ready():
	process_icon.texture = process_texture
