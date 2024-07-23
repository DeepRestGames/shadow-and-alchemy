extends Node3D

@onready var animation_player = $AnimationPlayer
@onready var candle = $Candle

@onready var right_page = $Body/PagesPivot/Right
@onready var left_page = $Body/Pages2Pivot/Left

func put_away():
	animation_player.play("disappear")
	
func pull_out():
	animation_player.play("appear")

func _ready():
	left_page.texture = load("res://Assets/2D/Decals/pg_1.png")
	right_page.texture = load("res://Assets/2D/Decals/pg_2.png")
	
func swapperoo():
	print("Swapping!")
	left_page.texture = load("res://Assets/2D/Decals/pg_3.png")
	right_page.texture = load("res://Assets/2D/Decals/pg_4.png")
	
func swapperoo_back():
	left_page.texture = load("res://Assets/2D/Decals/pg_1.png")
	right_page.texture = load("res://Assets/2D/Decals/pg_2.png")
	
