extends CanvasLayer

signal finished(success: bool)

@onready var button_box: HBoxContainer = %HBoxContainer
@onready var timer: Timer = %Timer2
@onready var success_label: Label = %Success_Fail
@onready var time_label: Label = %Timer

var buttonSelection = [
	{"action": "1", "icon": preload("res://Assets/Images/Sequence/crown.png")},
	{"action": "2", "icon": preload("res://Assets/Images/Sequence/left leg.png")},
	{"action": "3", "icon": preload("res://Assets/Images/Sequence/left temple.png")},
	{"action": "4", "icon": preload("res://Assets/Images/Sequence/right leg.png")},
	{"action": "5", "icon": preload("res://Assets/Images/Sequence/right temple.png")},
	{"action": "6", "icon": preload("res://Assets/Images/Sequence/stomach.png")},
]

var actionSequence = []
var sequenceIndex = 0

var sets_required := 3
var sets_completed := 0

func _ready() -> void:
	get_tree().paused = true
	success_label.hide()
	_start_new_set()

func _start_new_set() -> void:
	sequenceIndex = 0
	actionSequence.clear()
	_set_random_sequence()
	
	for node in button_box.get_children():
		node.modulate.a = 1
	
	timer.start()

func _set_random_sequence() -> void:
	for node in button_box.get_children():
		var randomPick = buttonSelection.pick_random()
		node.texture = randomPick.icon
		actionSequence.append(randomPick.action)

func _input(event: InputEvent) -> void:
	if not timer.time_left: return
	if not event is InputEventKey or not event.is_pressed(): return

	if Input.is_action_just_pressed(actionSequence[sequenceIndex]):
		_next_index()
	else:
		_reset_all()

func _next_index() -> void:
	button_box.get_child(sequenceIndex).modulate.a = 0
	
	sequenceIndex += 1
	
	if sequenceIndex >= actionSequence.size():
		sets_completed += 1
		
		if sets_completed >= sets_required:
			timer.paused = true
			_on_timer_timeout(true)
		else:
			_start_new_set()

func _reset_all() -> void:
	sequenceIndex = 0
	sets_completed = 0
	
	for node in button_box.get_children():
		node.modulate.a = 1

func _process(delta: float) -> void:
	var remainingTime = int(timer.time_left)
	time_label.text = str(remainingTime)

func _on_timer_timeout(success: bool = false) -> void:
	get_tree().paused = false
	_update_success_label(success)
	finished.emit(success)

func _update_success_label(success: bool) -> void:
	success_label.show()

	if success:
		success_label.text = "SUCCESS"
		success_label.add_theme_color_override("font_color", Color.GREEN)
	else:
		success_label.text = "FAIL"
		success_label.add_theme_color_override("font_color", Color.RED)

func handle_input(action: String) -> void:
	if not timer.time_left: return

	if action == actionSequence[sequenceIndex]:
		_next_index()
	else:
		_reset_all()

func _on_crown_pressed() -> void:
	handle_input("1")

func _on_left_leg_pressed() -> void:
	handle_input("2")

func _on_left_temple_pressed() -> void:
	handle_input("3")

func _on_right_leg_pressed() -> void:
	handle_input("4")

func _on_right_temple_pressed() -> void:
	handle_input("5")

func _on_stomach_pressed() -> void:
	handle_input("6")
