extends Control

@export var world_environment: WorldEnvironment

@onready var camera_3d = $"../../Camera3D"

# When the screen changes size, we need to update the 3D
# viewport quality setting. If we don't do this, the viewport will take
# the size from the main viewport.
var viewport_start_size := Vector2(
	ProjectSettings.get_setting(&"display/window/size/viewport_width"),
	ProjectSettings.get_setting(&"display/window/size/viewport_height")
)



func _on_fov_slider_value_changed(value: float) -> void:
	camera_3d.fov = value

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




func _on_master_slider_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), linear_to_db(value))

func _on_sat_slider_value_changed(value):
	world_environment.environment.tonemap_exposure = value

func _on_music_slider_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), linear_to_db(value))


func _on_sfx_slider_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("SFX"), linear_to_db(value))


func _on_hide_settings_button_pressed():
	hide()



