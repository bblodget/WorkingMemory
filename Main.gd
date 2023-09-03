extends Node

# When a scene wants to switch to another scene it
# emits a "scene_change" signal.
# All scenes must extend "BasicScene.gd" in order
# for it to be switchable.

var next_level = null

var current_level
@onready var anim = $AnimationPlayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	current_level = load("res://IntroScene.tscn").instantiate()
	add_child(current_level)
	
	current_level.scene_change.connect(handle_scene_change)
	current_level.show_scene()
	current_level.start_scene()
	
func handle_scene_change(next_level_name: String):

	next_level = load(next_level_name).instantiate()
	add_child(next_level)
	next_level.hide_scene()
	next_level.connect("scene_change", handle_scene_change)
		
	print("animation fade_out")
	anim.play("fade_out")
	
	

func _on_animation_player_animation_finished(anim_name):
	match anim_name:
		"fade_out":
			print("animation_finished: fade_out")
			current_level.scene_change.disconnect(handle_scene_change)
			current_level.finish_scene()
			current_level = next_level
			next_level = null
			current_level.show_scene()
			anim.play("fade_in")
		"fade_in":
			print("animation_finished: fade_in")
			current_level.start_scene()
