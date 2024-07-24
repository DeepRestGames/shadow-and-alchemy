extends Node

signal inventory_changed

var inventory_items: Array[InventoryItemData]


func add_item(item):
	inventory_items.append(item)
	inventory_changed.emit()


func remove_item(item):
	inventory_items.erase(item)
	inventory_changed.emit()
