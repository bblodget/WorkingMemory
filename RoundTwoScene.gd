extends "res://BasicScene.gd"

@onready var textbox = $Textbox

# Called when the node enters the scene tree for the first time.
func _ready():
	
	textbox.textbox_close.connect(_on_textbox_close)
	
	textbox.queue_text(
		"Same as round one, but this time add 1 modulo 10, " +
		"to each digit.  For example if the digits are 7 8 9, " +
		"the correct response is 8 9 0. " +
		"Each digit is worth 20 points. " +
		"\n\n<press spacebar to continue>"
	)
	
	
func _on_textbox_close():
	emit_signal("scene_change", "res://RoundThreeScene.tscn")

func show_scene():
	$CanvasLayer.visible = true
	textbox.visible = true
	
func hide_scene():
	$CanvasLayer.visible = false
	textbox.visible = false
	textbox.enable = false
	
func start_scene():
	textbox.enable = true
	

