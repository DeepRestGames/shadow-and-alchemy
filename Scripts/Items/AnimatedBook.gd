extends Node3D

@onready var animation_player = $AnimationPlayer
@onready var candle = $Candle

@onready var right_page = $Body/PagesPivot/Right
@onready var left_page = $Body/Pages2Pivot/Left
@onready var player = $".."

var is_book_open: bool = false

var pages: Array[String]
var current_left_page_index: int = 0:
	# Clamp
	set(value):
		# -2 cause 1 for 0 start and 2 because 2 pages at a time
		current_left_page_index = clamp(value, 0, (len(pages)-2))
	
signal sig_put_away
signal sig_pulled_out
	
func done_putting_away():
	sig_put_away.emit()
	is_book_open = false

func done_pulling_out():
	sig_pulled_out.emit()
	is_book_open = true
	
func put_away():
	animation_player.play("disappear")
	
func pull_out(d_path: String):
	if not is_book_open:
		animation_player.play("appear")
		pages.clear()
		_load_pages(d_path)
	
func _load_pages(d_path):
	var dir = DirAccess.open(d_path)
	dir.list_dir_begin()
	while true:
		var file_name = dir.get_next()
		if file_name == "":
			#break the while loop when get_next() returns ""
			break
		elif !file_name.begins_with(".") and !file_name.ends_with(".import"):
			#get_next() returns a string so this can be used to load the images into an array.
			pages.append((d_path + file_name))
	left_page.texture = load(pages[current_left_page_index])
	right_page.texture = load(pages[current_left_page_index+1])
	
func turn_right():
	current_left_page_index+=2
	left_page.texture = load(pages[current_left_page_index])
	right_page.texture = load(pages[current_left_page_index+1])
	
func turn_left():
	current_left_page_index-=2
	left_page.texture = load(pages[current_left_page_index])
	right_page.texture = load(pages[current_left_page_index+1])
	
