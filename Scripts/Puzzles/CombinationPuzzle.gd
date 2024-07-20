extends Control


@export var puzzle_configuration: Puzzle

@onready var value1 = $HBoxContainer/LineEdit1
@onready var value2 = $HBoxContainer/LineEdit2
@onready var value3 = $HBoxContainer/LineEdit3


func _process(_delta):
	
	if value1.text == puzzle_configuration.first_element.puzzle_element_name:
		if value2.text == puzzle_configuration.second_element.puzzle_element_name:
			if value3.text == puzzle_configuration.third_element.puzzle_element_name:
				print("Puzzle solved!")
				
				queue_free()
	
	
