class_name DiaryTag
extends CSGBox3D
#
@onready var collider_box = $"."
@onready var tag_name = $TagName

signal tag_pressed

#const non_highlighted_color: Color = Color(.5,.5,.5,1)
#const highlighted_color: Color = Color(1,1,1,1)
#
#func _highlight():
	#collider_box.material_override["albedo_color"] = highlighted_color
	#
#func _non_highlight():
	#collider_box.material_override["albedo_color"] = non_highlighted_color

func _pressed():
	tag_pressed.emit()
