extends ClickableReadable

@onready var item_book_black = $"."
@onready var sprite_3d = $Lable/Sprite3D
@onready var sprite_3d_2 = $Sprite3D2
@export var texture: Texture2D

@export var pages_path: String
@export var pages_array: Array[Texture2D]

signal open_diary_with_pages(pages_array)

func _ready():
	sprite_3d.texture=texture
	sprite_3d_2.texture=texture
	

func _clicked():
	open_diary_with_pages.emit(pages_array)
