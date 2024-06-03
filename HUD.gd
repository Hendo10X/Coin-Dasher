extends CanvasLayer

signal start_game()

func update_score(value):
	$MarginContainer/score.text = str(value)
	
func update_timer(value):
	$MarginContainer/time.text = str(value)
	
func show_message(text):
	$MessageLabel.text = text
	$MessageLabel.show()
	$MessageTimer.start()


func _on_message_timer_timeout():
	$MessageLabel.hide()


func _on_start_button_pressed():
	$StartButton.hide()
	$MessageLabel.hide()
	emit_signal("start_game")
	
func show_gameover():
	show_message("Game Over")
	await $MessageTimer.timeout
	$StartButton.show()
	$MessageLabel.text("Coin Dash")
	$MessageLabel.show()
