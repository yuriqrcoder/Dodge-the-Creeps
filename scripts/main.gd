extends Node

@export var mob_scene: PackedScene #the mob scene
var score #player's score

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

#runs when the game ends and stops the score and mob timers
func game_over():
	$ScoreTimer.stop()
	$MobTimer.stop()
	$HUD.show_game_over()
	$Music.stop() #stops the music
	$DeathSound.play() #plays the game over sound

#runs when a new game starts
func new_game():
	score = 0; #reset the score
	$Player.start($StartPosition.position) #start the player in the positiion
	$StartTimer.start() #start everything
	
	#updates the messages on the hud
	$HUD.update_score(score)
	$HUD.show_message("Get Ready")
	
	#removes all mobs
	get_tree().call_group("mobs", "queue_free")
	
	#plays the music
	$Music.play()

#runs to create new mobs
func _on_mob_timer_timeout():
	# Create a new instance of the Mob scene.
	var mob = mob_scene.instantiate()

	# Choose a random location on Path2D.
	var mob_spawn_location = $MobPath/MobSpawnLocation
	mob_spawn_location.progress_ratio = randf()

	# Set the mob's direction perpendicular to the path direction.
	var direction = mob_spawn_location.rotation + PI / 2

	# Set the mob's position to a random location.
	mob.position = mob_spawn_location.position

	# Add some randomness to the direction.
	direction += randf_range(-PI / 4, PI / 4)
	mob.rotation = direction

	# Choose the velocity for the mob.
	var velocity = Vector2(randf_range(150.0, 250.0), 0.0)
	mob.linear_velocity = velocity.rotated(direction)

	# Spawn the mob by adding it to the Main scene.
	add_child(mob)

#updates the score
func _on_score_timer_timeout():
	score += 1
	$HUD.update_score(score)

#runs when the start timer ends
func _on_start_timer_timeout():
	$MobTimer.start() #starts spawning the mobs
	$ScoreTimer.start() #starts to count the score
