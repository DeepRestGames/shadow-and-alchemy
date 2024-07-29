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


var diary_path: String = "res://Assets/DiaryPages/"
var pages: Array[String]
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

func _ready():
	var dir = DirAccess.open(diary_path)
	dir.list_dir_begin()
	while true:
		var file_name = dir.get_next()
		if file_name == "":
			#break the while loop when get_next() returns ""
			break
		elif !file_name.begins_with(".") and !file_name.ends_with(".import"):
			#get_next() returns a string so this can be used to load the images into an array.
			pages.append((diary_path + file_name))
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
	pass # Replace with function body.


func _on_studies_tag_pressed():
	# TODO
	options.hide()


func _on_options_tag_pressed():
	options.show()
