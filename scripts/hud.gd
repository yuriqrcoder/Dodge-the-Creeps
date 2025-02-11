extends CanvasLayer

signal start_game

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

#show the messages in the game
func show_message(text):
	$Message.text = text
	$Message.show()
	$MessageTimer.start()

#shows the game over message
func show_game_over():
	show_message("Game Over")
	# Wait until the MessageTimer has counted down.
	await $MessageTimer.timeout

	$Message.text = "Dodge the Creeps!"
	$Message.show()
	# Make a one-shot timer and wait for it to finish.
	await get_tree().create_timer(1.0).timeout
	$StartButton.show()

#updates the score label
func update_score(score):
	$ScoreLabel.text = str(score)

#runs when the button is pressed
func _on_start_button_pressed():
	$StartButton.hide() #hides the button
	start_game.emit() #starts the game

#runs to hide the messagem when the time ends
func _on_message_timer_timeout():
	$Message.hide()
