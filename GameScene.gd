extends "res://BasicScene.gd"


@onready var digit0 : MarginContainer = $CanvasLayer/MarginContainer/Rows/Numbers/Digit0
@onready var digit1 : MarginContainer = $CanvasLayer/MarginContainer/Rows/Numbers/Digit1
@onready var digit2 : MarginContainer = $CanvasLayer/MarginContainer/Rows/Numbers/Digit2
@onready var digit3 : MarginContainer = $CanvasLayer/MarginContainer/Rows/Numbers/Digit3
@onready var digit4 : MarginContainer = $CanvasLayer/MarginContainer/Rows/Numbers/Digit4
@onready var digit5 : MarginContainer = $CanvasLayer/MarginContainer/Rows/Numbers/Digit5
@onready var digit6 : MarginContainer = $CanvasLayer/MarginContainer/Rows/Numbers/Digit6


var digit : Array = [
	digit0, digit1, digit2, digit3,
	digit4, digit5, digit6
]

var score : int = 0
var num_digits : int = 3

enum State {
	SELECT,
	SHOW,
	HIDE,
	INPUT,
	FINISHED
}

var current_state : State = State.SELECT

enum Round {
	NORMAL,
	PLUS_ONE,
	PLUS_THREE
}

var current_round : Round = Round.NORMAL

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	
	
#func _on_begin_button_pressed():
#	emit_signal("scene_change", "res://RoundTwoScene.tscn")
	
#func _on_textbox_close():
#	emit_signal("scene_change", "res://RoundTwoScene.tscn")

func show_scene():
	$CanvasLayer.visible = true

func hide_scene():
	$CanvasLayer.visible = false

	
func start_scene():
	pass
	

