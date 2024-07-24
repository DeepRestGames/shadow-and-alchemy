extends TextureRect


# Handle Drag&Drop, using items, etc.
func _get_drag_data(_at_position):
	var preview_texture = TextureRect.new()
	preview_texture.texture = texture
	preview_texture.modulate = Color(1, 1, 1, .4)
	preview_texture.scale = Vector2(.3, .3)
	set_drag_preview(preview_texture)
	
	InteractionSystem.is_dragging_item = true
	InteractionSystem.dragged_item_data = name
	
	return name
