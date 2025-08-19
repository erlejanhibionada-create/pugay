extends Node2D

var enemy_hp = 100
var player_hp = 100

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_pressed() -> void:
	$AnimationPlayer.play("attack_player")

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "attack_player":
		$enemy/CharacterBody2D/Sprite2D/ProgressBar.value -= 20
	if anim_name == "defend_player":
		$player/CharacterBody2D/Sprite2D/ProgressBar.value -= 10

	
func _on_defend_pressed() -> void:
	$AnimationPlayer.play("defend_player")
