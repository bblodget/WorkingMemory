extends "res://BasicScene.gd"

@onready var textbox = $Textbox
@onready var begin_button : Button = $CanvasLayer/MarginContainer/BackRow/BeginButton


# Called when the node enters the scene tree for the first time.
func _ready():
	textbox.textbox_close.connect(_on_textbox_close)
	
	textbox.queue_text(
		"Test your working memory in three rounds. " +
		"Later rounds are worth more points." + 
		"\n\n<press spacebar to continue>"
	)
	
	
	
func _on_textbox_close():
	emit_signal("scene_change", "res://RoundOneScene.tscn")

func show_scene():
	$CanvasLayer.visible = true
	textbox.visible = true
	
func hide_scene():
	$CanvasLayer.visible = false
	textbox.visible = false
	textbox.enable = false
	
func start_scene():
	textbox.enable = true
	

