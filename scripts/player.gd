extends Area2D

signal hit

@export var speed = 400 #how fast the player will move (pixels/sec)
var screen_size #size of the game window

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size #get the size of the viewport
	hide() #hides the player when it starts


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var velocity = Vector2.ZERO #the player's movement vector
	
	#detects if a button is pressed and moves the player
	if Input.is_action_pressed("move_up"): #up
		velocity.y -= 1 
	if Input.is_action_pressed("move_down"): #down
		velocity.y += 1
	if Input.is_action_pressed("move_left"): #left
		velocity.x -= 1
	if Input.is_action_pressed("move_right"): #right
		velocity.x += 1
	
	#normalizes the player's movement
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite2D.play()
	else:
		$AnimatedSprite2D.stop()
	
	#don't let the player go out of the screen
	position += velocity * delta
	position = position.clamp(Vector2.ZERO, screen_size)
	
	#plays the right animation for the moves and flips the sprite
	if velocity.x != 0:
		$AnimatedSprite2D.animation = "walk"
		$AnimatedSprite2D.flip_v = false
		$AnimatedSprite2D.flip_h = velocity.x < 0
	elif velocity.y != 0:
		$AnimatedSprite2D.animation = "up"
		$AnimatedSprite2D.flip_v = velocity.y > 0

#detetcs if a enemy touches the player
func _on_body_entered(_body):
	hide()
	hit.emit()
	$CollisionShape2D.set_deferred("disabled", true)

#resets the position of the player
func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false
