extends Node2D
 
var enemies: Array = []
var action_queue: Array = []
var index: int = 0 
 
signal next_player
@onready var choice = $"../CanvasLayer/choice"
 
func _ready():
	enemies = get_children()
	for i in enemies.size():
		enemies[i].position = Vector2(0, i * 32)

func _process(_delta):
	if Input.is_action_just_pressed("ui_accept"):
		if enemies.size() > 0:
			action_queue.push_back(index) 
			_action(action_queue)
			action_queue.clear() 

func _action(stack):
	for i in stack:
		if i >= 0 and i < enemies.size(): 
			enemies[i].take_damage(1)
