extends Control

@onready var inventory_items_carousel = $InventoryUIContainer/InventoryItemsCarousel
@onready var inventory_item_scene = preload("res://Scenes/InventorySystem/InventoryItemUI.tscn")
var inventory_items: Array[InventoryItemUI]

var is_opened := false
@onready var animation_player = $AnimationPlayer


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


func open_inventory_called():
	if is_opened:
		animation_player.play_backwards("InventorySlideIn")
		is_opened = false
	else:
		animation_player.play("InventorySlideIn")
		is_opened = true
