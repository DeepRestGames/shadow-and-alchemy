extends ClickableReadable

@onready var item_book_black = $"."
@onready var sprite_3d = $Lable/Sprite3D
@onready var sprite_3d_2 = $Sprite3D2
@export var texture: Texture2D

@export var pages_path: String

signal open_diary_with_pages(page_path)

func _ready():
	sprite_3d.texture=texture
	sprite_3d_2.texture=texture
	

func _clicked():
	open_diary_with_pages.emit(pages_path)
