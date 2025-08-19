extends Node2D

var enemy_hp = 100
var player_hp = 100
var StrikeSequenceScene = preload("res://Scenes/strike_sequence.tscn")

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	pass

func _on_button_pressed() -> void:
	$AnimationPlayer.play("attack_player")

func _on_defend_pressed() -> void:
	$AnimationPlayer.play("defend_player")

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "attack_player":
		var enemy_bar = get_node_or_null("enemy/CharacterBody2D/ProgressBar")
		if enemy_bar:
			enemy_bar.value -= 20
		else:
			push_error("⚠️ enemy ProgressBar not found!")

	elif anim_name == "defend_player":
		var player_bar = get_node_or_null("player/CharacterBody2D/ProgressBar")
		if player_bar:
			player_bar.value -= 0  # Optional
		else:
			push_error("⚠️ player ProgressBar not found!")

		var strike_sequence = StrikeSequenceScene.instantiate()
		strike_sequence.finished.connect(_on_strike_sequence_finished)
		add_child(strike_sequence)

func _on_strike_sequence_finished(success: bool) -> void:
	if success:
		var enemy_bar = get_node_or_null("enemy/CharacterBody2D/ProgressBar")
		if enemy_bar:
			var damage = enemy_bar.max_value * 0.2
			enemy_bar.value -= damage
		else:
			push_error("⚠️ enemy ProgressBar not found!")
	else:
		print("Strike sequence failed.")

func _on_journal_pressed() -> void:
	print("Journal pressed")

func _on_menu_pressed() -> void:
	print("Menu pressed")
