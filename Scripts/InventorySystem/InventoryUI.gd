extends Control

@onready var inventory_items_carousel = $InventoryUIContainer/InventoryItemsCarousel
@onready var inventory_item_scene = preload("res://Scenes/InventorySystem/InventoryItemUI.tscn")
var inventory_items: Array[InventoryItemUI]

var is_opened := false
var viewport_height: float
var opened_position: Vector2
var closed_position: Vector2
@onready var inventory_ui_container = $InventoryUIContainer


func _ready():
	InventorySystem.inventory_changed.connect(_update_inventory_ui)
	
	viewport_height = get_viewport_rect().size.y
	closed_position = Vector2(0, viewport_height)
	opened_position = Vector2(0, viewport_height - inventory_ui_container.size.y)


func _update_inventory_ui():
	# Clear current inventory items
	for item in inventory_items:
		item.free()
	inventory_items.clear()
	
	# Add updated inventory items
	for item in InventorySystem.inventory_items:
		var current_item_scene = inventory_item_scene.instantiate() as InventoryItemUI
		current_item_scene.icon.texture = item.item_icon
		current_item_scene.icon.tooltip_text = item.item_name
		current_item_scene.item_data = item
		
		inventory_items_carousel.add_child(current_item_scene)
		inventory_items.append(current_item_scene)


func open_inventory_called():
	if is_opened:
		var tween = get_tree().create_tween()
		tween.set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_IN_OUT).tween_property(inventory_ui_container, "position", closed_position, 1)
		
		is_opened = false
	else:
		var tween = get_tree().create_tween()
		tween.set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_IN_OUT).tween_property(inventory_ui_container, "position", opened_position, 1)
		
		is_opened = true


func _on_central_arrow_pressed():
	open_inventory_called()


func _on_right_arrow_pressed():
	InventorySystem.move_items_right()


func _on_left_arrow_pressed():
	InventorySystem.move_items_left()
