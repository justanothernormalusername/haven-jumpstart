extends CharacterBody2D


const SPEED = 10.0
const JUMP_VELOCITY = -900.0

var score = 0


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	#var direction := Input.get_axis("left", "right")
	#if direction:
		#velocity.x = direction * SPEED
	#else:
		#velocity.x = move_toward(velocity.x, 0, SPEED)
	
	if Input.is_action_pressed("left"):
		velocity.x -= SPEED
	elif Input.is_action_pressed("right"):
		velocity.x += SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	if velocity.x > 0 and $AnimatedSprite2D.animation != "move":
		$AnimatedSprite2D.animation = "move"
		$AnimatedSprite2D.flip_h = true
	elif velocity.x < 0 and $AnimatedSprite2D.animation != "move":
		$AnimatedSprite2D.animation = "move"
		$AnimatedSprite2D.flip_h = false
	elif velocity.x == 0 and $AnimatedSprite2D.animation != "idle":
		$AnimatedSprite2D.animation = "idle"
	
	if position.y > 1000:
		reset()
	
	if position.x > score:
		score = position.x
		$Camera2D/Label.text = "Score: " + str(int(score))

	move_and_slide()

func reset() -> void:
	position = Vector2.ZERO
	velocity = Vector2.ZERO


func win(area: Area2D) -> void:
	$Camera2D/Label.text = "You win!"
