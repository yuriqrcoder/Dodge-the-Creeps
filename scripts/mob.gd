extends RigidBody2D

# Called when the node enters the scene tree for the first time.
func _ready():
	#randomly selects the mob animations
	var mob_types = $AnimatedSprite2D.sprite_frames.get_animation_names()
	$AnimatedSprite2D.play(mob_types[randi() % mob_types.size()])

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

#deletes the mob when they get out of the screen
func _on_visible_on_screen_enabler_2d_screen_exited():
	queue_free()
