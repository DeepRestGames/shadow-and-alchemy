class_name Prop_Pickup
extends Prop


@export var inventory_item_data: InventoryItemData
@export var item_model_height: float


func _interacted():
	InventorySystem.add_item(inventory_item_data)
	
	print("Item added to inventory!")
	
	queue_free()
