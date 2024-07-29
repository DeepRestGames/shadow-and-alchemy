extends Node

signal inventory_changed

var inventory_items: Array[InventoryItemData]


func add_item(item):
	inventory_items.append(item)
	inventory_changed.emit()


func remove_item(item):
	inventory_items.erase(item)
	inventory_changed.emit()


func move_items_right():
	if inventory_items.size() < 2:
		return
	
	var temp_array = inventory_items.duplicate()
	
	var last_element = inventory_items[inventory_items.size() - 1]
	
	for i in range(temp_array.size() -2, -1, -1):
		temp_array[i + 1] = temp_array[i]
	
	temp_array[0] = last_element
	
	inventory_items = temp_array
	inventory_changed.emit()


func move_items_left():
	if inventory_items.size() < 2:
		return
	
	var temp_array = inventory_items.duplicate()
	
	var first_element = inventory_items[0]
	
	for i in range(1, temp_array.size()):
		temp_array[i - 1] = temp_array[i]
	
	temp_array[temp_array.size() - 1] = first_element
	
	inventory_items = temp_array
	inventory_changed.emit()
