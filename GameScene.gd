extends "res://BasicScene.gd"

@onready var instruction_container : MarginContainer = $CanvasLayer/MarginContainer/Rows/MarginContainer
@onready var instructions : MarginContainer = $CanvasLayer/MarginContainer/Rows/MarginContainer/Textbox2

@onready var numbers : HBoxContainer = $CanvasLayer/MarginContainer/Rows/Numbers
@onready var digit0 : MarginContainer = $CanvasLayer/MarginContainer/Rows/Numbers/Digit0
@onready var digit1 : MarginContainer = $CanvasLayer/MarginContainer/Rows/Numbers/Digit1
@onready var digit2 : MarginContainer = $CanvasLayer/MarginContainer/Rows/Numbers/Digit2
@onready var digit3 : MarginContainer = $CanvasLayer/MarginContainer/Rows/Numbers/Digit3
@onready var digit4 : MarginContainer = $CanvasLayer/MarginContainer/Rows/Numbers/Digit4
@onready var digit5 : MarginContainer = $CanvasLayer/MarginContainer/Rows/Numbers/Digit5
@onready var digit6 : MarginContainer = $CanvasLayer/MarginContainer/Rows/Numbers/Digit6

@onready var digit_label0 : Label = $CanvasLayer/MarginContainer/Rows/Numbers/Digit0/MarginContainer/HBoxContainer/Value
@onready var digit_label1 : Label = $CanvasLayer/MarginContainer/Rows/Numbers/Digit1/MarginContainer/HBoxContainer/Value
@onready var digit_label2 : Label = $CanvasLayer/MarginContainer/Rows/Numbers/Digit2/MarginContainer/HBoxContainer/Value
@onready var digit_label3 : Label = $CanvasLayer/MarginContainer/Rows/Numbers/Digit3/MarginContainer/HBoxContainer/Value
@onready var digit_label4 : Label = $CanvasLayer/MarginContainer/Rows/Numbers/Digit4/MarginContainer/HBoxContainer/Value
@onready var digit_label5 : Label = $CanvasLayer/MarginContainer/Rows/Numbers/Digit5/MarginContainer/HBoxContainer/Value
@onready var digit_label6 : Label = $CanvasLayer/MarginContainer/Rows/Numbers/Digit6/MarginContainer/HBoxContainer/Value


var digit : Array = []
var digit_label : Array = []
var digit_value : Array = [0, 0, 0, 0, 0, 0, 0]

var score : int = 0
var num_digits : int = 3

var enable : bool = false

const MAX_DIGITS = 7

enum State {
	INSTRUCTIONS,
	WAIT,
	SELECT,
	HIDE,
	INPUT,
	FINISHED
}

var current_state : State = State.INSTRUCTIONS

enum Round {
	NORMAL,
	PLUS_ONE,
	PLUS_THREE
}

var current_round : Round = Round.NORMAL

var tween : Tween

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()  # Seed the random number generator
	
	instructions.textbox_close.connect(_on_textbox_close)
	
	digit.append(digit0)
	digit.append(digit1)
	digit.append(digit2)
	digit.append(digit3)
	digit.append(digit4)
	digit.append(digit5)
	digit.append(digit6)
	
	digit_label.append(digit_label0)
	digit_label.append(digit_label1)
	digit_label.append(digit_label2)
	digit_label.append(digit_label3)
	digit_label.append(digit_label4)
	digit_label.append(digit_label5)
	digit_label.append(digit_label6)
	
	#start_scene()
	
	
#func _on_begin_button_pressed():
#	emit_signal("scene_change", "res://RoundTwoScene.tscn")
	
#func _on_textbox_close():
#	emit_signal("scene_change", "res://RoundTwoScene.tscn")

func show_scene():
	$CanvasLayer.visible = true

func hide_scene():
	$CanvasLayer.visible = false

	
func start_scene():
	current_state = State.INSTRUCTIONS
	current_round = Round.NORMAL
	enable = true
	
	
func _process(delta):
	match current_state:
		State.INSTRUCTIONS:
			if enable:
				_show_instructions()
		State.WAIT:
			pass
		State.SELECT:
			_select_number()
		State.HIDE:
			pass
			
func _show_instructions():
	match current_round:
		Round.NORMAL:
			instructions.queue_text(
		"Remember the digits in the boxes as they fade away. " +
		"As each box is highlighted type the number that was in the box. " +
		"Each digit is worth 10 points. " +
		"\n\n<press spacebar to continue>")

		Round.PLUS_ONE:
			instructions.queue_text(
		"Same as round one, but this time add 1 modulo 10, " +
		"to each digit.  For example if the digits are 7 8 9, " +
		"the correct response is 8 9 0. " +
		"Each digit is worth 20 points. " +
		"\n\n<press spacebar to continue>")

		Round.PLUS_THREE:
			instructions.queue_text(
		"Same as round two, but this time add 3 modulo 10, " +
		"to each digit.  For example if the digits are 7 8 9, " +
		"the correct response is 0 1 2. " +
		"Each digit is worth 30 points. " +
		"\n\n<press spacebar to continue>")
	
	instruction_container.visible = true
	numbers.visible = false
		
	instructions.visible = true
	instructions.enable = true
	current_state = State.WAIT
			
			
func _on_textbox_close():
	instructions.visible = false
	instructions.enable = false
	current_state = State.SELECT
	
func _select_number():
	instruction_container.visible = false
	numbers.visible = true
	
	for i in range(MAX_DIGITS):
		if i < num_digits:
			digit[i].visible = true
			digit_value[i] = randi() % 10
			digit_label[i].text = str(digit_value[i])
		else:
			digit[i].visible = false
			
	# Hide the numbers
	current_state = State.HIDE
	#tween = create_tween()
	#tween.set_trans(Tween.TRANS_LINEAR)
	#tween.set_ease(Tween.EASE_IN_OUT)
	#for i in range(num_digits):
	#	tween.tween_property(digit_label[i], "theme_override_colors/font_color", Color(1,1,1,0), 0.5).from(Color(1,1,1,1))
	#tween.tween_callback(_on_tween_all_completed)
	
func _on_tween_all_completed():
	print("done hidding")
	current_state = State.FINISHED
			
	

			

