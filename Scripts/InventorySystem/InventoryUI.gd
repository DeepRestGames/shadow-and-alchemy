extends Control

@onready var inventory_items_carousel = $InventoryItemsCarousel
@onready var inventory_item_scene = preload("res://Scenes/InventorySystem/InventoryItemUI.tscn")
var inventory_items: Array[InventoryItemUI]


func _ready():
	InventorySystem.inventory_changed.connect(_update_inventory_ui)


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
	
