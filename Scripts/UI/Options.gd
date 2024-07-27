extends Control


# Window project settings:
#  - Stretch mode is set to `canvas_items` (`2d` in Godot 3.x)
#  - Stretch aspect is set to `expand`
var counter := 0.0
@onready var world_environment = $"../WorldEnvironment"
@onready var player = $"../Player"

# When the screen changes size, we need to update the 3D
# viewport quality setting. If we don't do this, the viewport will take
# the size from the main viewport.
var viewport_start_size := Vector2(
	ProjectSettings.get_setting(&"display/window/size/viewport_width"),
	ProjectSettings.get_setting(&"display/window/size/viewport_height")
)


func _ready() -> void:
	#get_viewport().size_changed.connect(update_resolution_label)
	#update_resolution_label()

	# Disable V-Sync to uncap framerate on supported platforms. This makes performance comparison
	# easier on high-end machines that easily reach the monitor's refresh rate.
	DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_DISABLED)


func _process(delta: float) -> void:
	counter += delta
	# Hide FPS label until it's initially updated by the engine (this can take up to 1 second).
	#fps_label.visible = counter >= 1.0
	#fps_label.text = "%d FPS (%.2f mspf)" % [Engine.get_frames_per_second(), 1000.0 / Engine.get_frames_per_second()]
	## Color FPS counter depending on framerate.
	## The Gradient resource is stored as metadata within the FPSLabel node (accessible in the inspector).
	#fps_label.modulate = fps_label.get_meta("gradient").sample(remap(Engine.get_frames_per_second(), 0, 180, 0.0, 1.0))


func _on_fov_slider_value_changed(value: float) -> void:
	player.camera_3d.fov = value

func _on_brightness_slider_value_changed(value: float) -> void:
	# This is a setting that is attached to the environment.
	# If your game requires you to change the environment,
	# then be sure to run this function again to make the setting effective.
	# The slider value is clamped between 0.5 and 4.
	world_environment.environment.set_adjustment_brightness(value)


func _on_contrast_slider_value_changed(value: float) -> void:
	# This is a setting that is attached to the environment.
	# If your game requires you to change the environment,
	# then be sure to run this function again to make the setting effective.
	# The slider value is clamped between 0.5 and 4.
	world_environment.environment.set_adjustment_contrast(value)


func _on_saturation_slider_value_changed(value: float) -> void:
	# This is a setting that is attached to the environment.
	# If your game requires you to change the environment,
	# then be sure to run this function again to make the setting effective.
	# The slider value is clamped between 0.5 and 10.
	world_environment.environment.set_adjustment_saturation(value)
