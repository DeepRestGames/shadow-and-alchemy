extends Node3D

@onready var animation_player = $AnimationPlayer
var is_open: bool = false
@onready var left_page = $Body/L/Pages2Pivot/Left
@onready var right_page = $Body/R/PagesPivot/Right
@onready var open_collider = $OpenCollider

func _ready():
	_load_pages("res://Assets/2D/Books/Grimoire/")

func _on_open_collider_has_been_clicked():
	if not is_open:
		animation_player.play("open")
		is_open = true
		open_collider.use_collision = false
		
func _on_left_collider_has_been_clicked():
	if is_open and not animation_player.is_playing():
		turn_left()


func _on_right_collider_has_been_clicked():
	if is_open and not animation_player.is_playing():
		turn_right()

@export var pages: Array[Texture2D]

var current_left_page_index: int = 0:
	# Clamp
	set(value):
		# -2 cause 1 for 0 start and 2 because 2 pages at a time
		current_left_page_index = clamp(value, 0, (len(pages)-2))
		
		
func _load_pages(d_path):
	#var dir = DirAccess.open(d_path)
	#dir.list_dir_begin()
	#while true:
		#var file_name = dir.get_next()
		#if file_name == "":
			##break the while loop when get_next() returns ""
			#break
		#elif !file_name.begins_with(".") and !file_name.ends_with(".import"):
			##get_next() returns a string so this can be used to load the images into an array.
			#pages.append((d_path + file_name)) 
	left_page.texture = pages[current_left_page_index]
	right_page.texture = pages[current_left_page_index+1]
	
func turn_right():
	current_left_page_index+=2
	left_page.texture = pages[current_left_page_index]
	right_page.texture = pages[current_left_page_index+1]
	
func turn_left():
	if current_left_page_index == 0:
		animation_player.play("close")
		is_open = false
		open_collider.use_collision = true
	current_left_page_index-=2
	left_page.texture = pages[current_left_page_index]
	right_page.texture = pages[current_left_page_index+1]



