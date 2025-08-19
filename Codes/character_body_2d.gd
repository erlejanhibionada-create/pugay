extends CharacterBody2D
 
@onready var progress_bar = $ProgressBar
 
@export var MAX_HEALTH: float = 7
var health: float = 7:
	set(value):
		health = value
		_update_progress_bar()
		if health <= 0:
			queue_free()  
 
func _update_progress_bar():
	progress_bar.value = (health / MAX_HEALTH) * 100

func take_damage(value):
	health -= value
