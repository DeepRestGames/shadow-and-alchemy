extends Node3D

@onready var sprite_3d = $Lable/Sprite3D
@onready var sprite_3d_2 = $Sprite3D2
@export var texture: Texture2D

func _ready():
	sprite_3d.texture=texture
	sprite_3d_2.texture=texture
	
	

