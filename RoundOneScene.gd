extends "res://BasicScene.gd"

@onready var textbox = $Textbox

# Called when the node enters the scene tree for the first time.
func _ready():
	textbox.textbox_close.connect(_on_textbox_close)
	
	textbox.queue_text(
		"Remember the digits in the boxes as they fade away. " +
		"As each box is highlighted type the number that was in the box. " +
		"Each digit is worth 10 points. " +
		"\n\n<press spacebar to continue>"
	)
	
	
func _on_textbox_close():
	emit_signal("scene_change", "res://GameScene.tscn")

func show_scene():
	$CanvasLayer.visible = true
	textbox.visible = true
	
func hide_scene():
	$CanvasLayer.visible = false
	textbox.visible = false
	textbox.enable = false
	
func start_scene():
	textbox.enable = true
	

