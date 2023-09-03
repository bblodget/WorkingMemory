extends Node

signal scene_change(next_level_name)

var level_parameters := {}


func load_level_parameters(new_level_parameters: Dictionary):
	level_parameters = new_level_parameters

# Called when we want to show the scene
func show_scene():
	pass

# Called when we want to hide the scene
func hide_scene():
	pass

# Called when the node enters the scene tree for the first time.
func start_scene():
	pass

	
func finish_scene():
	#$ColorRect.set_mouse_filter(Control.MOUSE_FILTER_IGNORE)
	#$ClickButton.set_mouse_filter(Control.MOUSE_FILTER_IGNORE)
	#if $ButtonClickedSound.playing:
	#	yield($ButtonClickedSound,"finished")
	queue_free()
	
# Note implement a handler like this to switch scenes
#func _on_ChangeSceneButton_pressed():
#	#$ButtonClickedSound.play()
#	#$ChangeSceneButton.disabled = true
#	#$ClickButton.disabled = true
#	emit_signal("scene_change", level_name)

