class_name Prop_Pickup
extends Prop


@export var inventory_item_data: InventoryItemData


func _interacted():
	InventorySystem.add_item(inventory_item_data)
	
	print("Item added to inventory!")
	
	queue_free()
