extends MarginContainer

# Reference video
# https://youtu.be/QEHOiORnXIk?si=XOPLRZxFhMxDn7EW

const CHAR_READ_RATE = 0.05

@onready var textbox_container = $"."
@onready var start_symbol = $MarginContainer/HBoxContainer/Start
@onready var end_symbol = $MarginContainer/HBoxContainer/End
@onready var label = $MarginContainer/HBoxContainer/Label

var tween : Tween
var enable : bool = false

signal textbox_close


enum State {
	READY,
	READING,
	FINISHED
}

var current_state = State.READY
var text_queue : Array = []


# Called when the node enters the scene tree for the first time.
func _ready():
	print("Starting state: State.READY")
	hide_textbox()
	
func _process(delta):
	match current_state:
		State.READY:
			if !text_queue.is_empty() and enable:
				display_text()
		State.READING:
			if Input.is_action_just_pressed("ui_accept"):
				label.visible_ratio = 1.0
				tween.stop()
				# end_symbol.text = "v"
				change_state(State.FINISHED)
				
		State.FINISHED:
			# enter is ui_accept
			if Input.is_action_just_pressed("ui_accept"):
				change_state(State.READY)
				hide_textbox()
				textbox_close.emit()
				
				#if !text_queue.is_empty():
				#	change_state(State.READY)
				#	hide_textbox()
				#else:
				#	textbox_close.emit()

func queue_text(next_text):
	text_queue.push_back(next_text)
	
func clear():
	hide_textbox()
	text_queue.clear()

func hide_textbox():
	start_symbol.text = ""
	end_symbol.text = ""
	label.text = ""
	# textbox_container.hide()
	
func show_textbox():
	# start_symbol.text = "*"
	textbox_container.show()
	
func display_text():
	var next_text = text_queue.pop_front()
	label.text = next_text
	label.visible_ratio = 0.0
	change_state(State.READING)
	show_textbox()
	tween = create_tween()
	tween.set_trans(Tween.TRANS_LINEAR)
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(label, "visible_ratio", 1.0, len(next_text) * CHAR_READ_RATE ).from(0.0)
	tween.tween_callback(_on_tween_all_completed)
	
func _on_tween_all_completed():
	# end_symbol.text = "v"
	change_state(State.FINISHED)
	

func change_state(next_state):
	current_state = next_state
	match current_state:
		State.READY:
			print("Changing state to: State.READY")
		State.READING:
			print("Changing state to: State.READING")
		State.FINISHED:
			print("Changing state to: State.FINISHED")
	
	
	
	
	

