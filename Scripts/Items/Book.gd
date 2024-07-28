extends CSGBox3D

@onready var item_book_black = $"."
@onready var sprite_3d = $Lable/Sprite3D
@onready var sprite_3d_2 = $Sprite3D2
@export var texture: Texture2D

# Called when the node enters the scene tree for the first time.
func _ready():
	sprite_3d.texture=texture
	sprite_3d_2.texture=texture
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
