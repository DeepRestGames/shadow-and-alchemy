extends Control


# Window project settings:
#  - Stretch mode is set to `canvas_items` (`2d` in Godot 3.x)
#  - Stretch aspect is set to `expand`
#@onready var world_environment = $"../WorldEnvironment"
@onready var player = $"../Player"

# When the screen changes size, we need to update the 3D
# viewport quality setting. If we don't do this, the viewport will take
# the size from the main viewport.
var viewport_start_size := Vector2(
	ProjectSettings.get_setting(&"display/window/size/viewport_width"),
	ProjectSettings.get_setting(&"display/window/size/viewport_height")
)



func _on_fov_slider_value_changed(value: float) -> void:
	player.camera_3d.fov = value

#func _on_brightness_slider_value_changed(value: float) -> void:
	#world_environment.environment.set_adjustment_brightness(value)
#
#
#func _on_contrast_slider_value_changed(value: float) -> void:
	#world_environment.environment.set_adjustment_contrast(value)
#
#
#func _on_saturation_slider_value_changed(value: float) -> void:
	#world_environment.environment.set_adjustment_saturation(value)


