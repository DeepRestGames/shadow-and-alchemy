extends Node3D

signal interacted

@onready var animation_player = $AnimationPlayer
@onready var candle = $Candle

@onready var right_page = $Body/PagesPivot/Right
@onready var left_page = $Body/Pages2Pivot/Left

@onready var tags = $Tags
@onready var collider_box_codex = $Tags/Codex/ColliderBox
@onready var collider_box_studies = $Tags/Studies/ColliderBox
@onready var collider_box_options = $Tags/Options/ColliderBox
@onready var options = $Options


#var studies_path: String = "res://Assets/2D/Books/Journal/"
#var codex_path: String = "res://Assets/2D/Books/Codex/"
var studies_name: String = "STUDIES"
var codex_name: String = "CODEX"

@export var studies_array: Array[Texture2D]
@export var codex_array: Array[Texture2D]

var pages: Array[Texture2D]
var current_left_page_index: int = 0:
	# Clamp
	set(value):
		# -2 cause 1 for 0 start and 2 because 2 pages at a time
		current_left_page_index = clamp(value, 0, (len(pages)-2))

func put_away():
	animation_player.play("disappear")
	interacted.emit()

func pull_out():
	animation_player.play("appear")
	interacted.emit()
	
func _load_pages(pages_path):
	#var dir = DirAccess.open(pages_path)
	#dir.list_dir_begin()
	#while true:
		#var file_name = dir.get_next()
		#if file_name == "":
			##break the while loop when get_next() returns ""
			#break
		#elif !file_name.begins_with(".") and !file_name.ends_with(".import"):
			##get_next() returns a string so this can be used to load the images into an array.
			#pages.append((pages_path + file_name))
	if pages_path == codex_name:
		pages = codex_array
	elif pages_path == studies_name:
		pages = studies_array
	left_page.texture = pages[current_left_page_index]
	right_page.texture = pages[current_left_page_index+1]

func _ready():
	_load_pages(codex_name)

func turn_right():
	current_left_page_index+=2
	left_page.texture = pages[current_left_page_index]
	right_page.texture = pages[current_left_page_index+1]

func turn_left():
	current_left_page_index-=2
	left_page.texture = pages[current_left_page_index]
	right_page.texture = pages[current_left_page_index+1]


func show_tags():
	tags.show()
	collider_box_codex.use_collision = true
	collider_box_studies.use_collision = true
	collider_box_options.use_collision = true

func hide_tags():
	tags.hide()
	collider_box_codex.use_collision = false
	collider_box_studies.use_collision = false
	collider_box_options.use_collision = false



func _on_codex_tag_pressed():
	current_left_page_index =0
	_load_pages(codex_name)



func _on_studies_tag_pressed():
	current_left_page_index =0
	_load_pages(studies_name)



func _on_options_tag_pressed():
	options.show()
