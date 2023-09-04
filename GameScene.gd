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

@onready var hide_timer : Timer = $HideTimer
@onready var select_timer : Timer = $SelectTimer

# Amount of time to show the numbers
var show_time : float = 2.0

var digit : Array = []
var digit_label : Array = []
var digit_value : Array = [0, 0, 0, 0, 0, 0, 0]

var score : int = 0
var num_digits : int = 3

var enable : bool = false

const MAX_DIGITS = 7

const YELLOW : Color = Color(0.898039, 0.803922, 0.278431, 1)
const WHITE : Color = Color(0.796078, 0.796078, 0.796078, 1)
const BLACK : Color = Color(0.0392157, 0.0392157, 0.0392157, 1)
const RED : Color = Color(0.764706, 0.14902, 0.0862745, 1)
const GREEN : Color = Color(0.152941, 0.705882, 0.0745098, 1)


enum State {
	INSTRUCTIONS,
	WAIT,
	SELECT,
	HIDE,
	INPUT,
	WAIT_USER,
	FINISHED
}

var current_state : State = State.INSTRUCTIONS

enum Round {
	NORMAL,
	PLUS_ONE,
	PLUS_THREE
}

var current_round : Round = Round.NORMAL

var style_white : StyleBoxFlat
var style_yellow : StyleBoxFlat
var style_green : StyleBoxFlat
var style_red : StyleBoxFlat


var target_digit = 0

var correct_digit : bool = false


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
	
	_setup_styles()
	
	start_scene()
	
func _setup_styles():
	style_white = StyleBoxFlat.new()
	style_yellow = StyleBoxFlat.new()
	style_red = StyleBoxFlat.new()
	style_green = StyleBoxFlat.new()
	
	# Setup style_white
	style_white.bg_color = BLACK
	style_white.border_width_left = 10
	style_white.border_width_top = 10
	style_white.border_width_right = 10
	style_white.border_width_bottom = 10
	style_white.border_color = WHITE
	style_white.corner_radius_top_left = 20
	style_white.corner_radius_top_right = 20
	style_white.corner_radius_bottom_right = 20
	style_white.corner_radius_bottom_left = 20
	style_white.corner_detail = 10
	
	# Setup style_yellow
	style_yellow.bg_color = BLACK
	style_yellow.border_width_left = 10
	style_yellow.border_width_top = 10
	style_yellow.border_width_right = 10
	style_yellow.border_width_bottom = 10
	style_yellow.border_color = YELLOW
	style_yellow.corner_radius_top_left = 20
	style_yellow.corner_radius_top_right = 20
	style_yellow.corner_radius_bottom_right = 20
	style_yellow.corner_radius_bottom_left = 20
	style_yellow.corner_detail = 10
	
	# Setup style_red
	style_red.bg_color = BLACK
	style_red.border_width_left = 10
	style_red.border_width_top = 10
	style_red.border_width_right = 10
	style_red.border_width_bottom = 10
	style_red.border_color = RED
	style_red.corner_radius_top_left = 20
	style_red.corner_radius_top_right = 20
	style_red.corner_radius_bottom_right = 20
	style_red.corner_radius_bottom_left = 20
	style_red.corner_detail = 10
	
	# Setup style_green
	style_green.bg_color = BLACK
	style_green.border_width_left = 10
	style_green.border_width_top = 10
	style_green.border_width_right = 10
	style_green.border_width_bottom = 10
	style_green.border_color = GREEN
	style_green.corner_radius_top_left = 20
	style_green.corner_radius_top_right = 20
	style_green.corner_radius_bottom_right = 20
	style_green.corner_radius_bottom_left = 20
	style_green.corner_detail = 10
	
	# Set all the styles to white initially 
	for i in range(MAX_DIGITS):
		var panel : Panel = digit[i].get_node("Panel") 
		panel.add_theme_stylebox_override("panel", style_white)
		
	
	
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

func _input(event):
	if event is InputEventKey:
		if event.pressed:
			match event.keycode:
				KEY_0, KEY_KP_0 : 
					_handle_number(0)
				KEY_1, KEY_KP_1 : 
					_handle_number(1)
				KEY_2, KEY_KP_2 : 
					_handle_number(2)
				KEY_3, KEY_KP_3 : 
					_handle_number(3)
				KEY_4, KEY_KP_4 : 
					_handle_number(4)
				KEY_5, KEY_KP_5 : 
					_handle_number(5)
				KEY_6, KEY_KP_6 : 
					_handle_number(6)
				KEY_7, KEY_KP_7 : 
					_handle_number(7)
				KEY_8, KEY_KP_8 : 
					_handle_number(8)
				KEY_9, KEY_KP_9 : 
					_handle_number(9)
	
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
		State.INPUT:
			_input_numbers()
		State.WAIT_USER:
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
			
	# Show the numbers for a period
	current_state = State.HIDE
	hide_timer.start(show_time)
	

func _on_hide_timer_timeout():
	print("hide numbers")
	for i in range(num_digits):
		digit_label[i].visible = false
	
	current_state = State.INPUT
	

func _input_numbers():
	current_state = State.WAIT_USER
	
	# Wait one second
	await get_tree().create_timer(1.0).timeout
	
	for i in range(num_digits):
		print("highlight: digit"+str(i))
		target_digit = i
		correct_digit = false
		
		# Get the child Panel of the current digit MarginContainer
		var panel : Panel = digit[i].get_node("Panel") 
		
		# Make digit box yellow
		panel.add_theme_stylebox_override("panel", style_yellow)
		
		# Wait one second
		await get_tree().create_timer(2.0).timeout
		
		# Color box green if correct else red
		if correct_digit:
			# Make digit box green
			panel.add_theme_stylebox_override("panel", style_green)
		else:
			panel.add_theme_stylebox_override("panel", style_red)
		
		
func _handle_number(user_value):
	if current_state != State.WAIT_USER:
		return
	
	var target_value : int = int(digit_label[target_digit].text)
	
	print("user_value: "+str(user_value)+" target_value: "+str(target_value))
	if user_value == target_value:
		correct_digit = true
		print("correct!")
	else:
		correct_digit = false
		print("wrong!")
		
	# display the user value in the box
	digit_label[target_digit].text = str(user_value)
	digit_label[target_digit].visible = true
	
	
	

