class_name ClickableReadable
extends CSGBox3D

signal has_been_clicked

func _clicked():
	has_been_clicked.emit()
