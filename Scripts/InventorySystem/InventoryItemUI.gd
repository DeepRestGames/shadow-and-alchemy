class_name InventoryItemUI
extends Control


@export var icon: TextureRect
@export var item_name_label: Label
var item_data: InventoryItemData


# Handle Drag&Drop, using items, etc.
func _get_drag_data(_at_position):
	Input.set_custom_mouse_cursor(InteractionSystem.mouse_cursor_drag)
	
	var preview_texture = TextureRect.new()
	preview_texture.texture = icon.texture
	preview_texture.modulate = Color(1, 1, 1, .4)
	preview_texture.scale = Vector2(.3, .3)
	set_drag_preview(preview_texture)
	
	InteractionSystem.is_dragging_item = true
	InteractionSystem.dragged_item_data = item_data
	
	return item_data.item_name
