extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

@onready var handL: Marker2D = $PlayerIKBody/CharacterContainer/Body/GBotForearmL/HandL
@onready var handR: Marker2D = $PlayerIKBody/CharacterContainer/Body/GBotForearmR/HandR
@onready var gameManager: Node = $"../../GameManager"

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("Tug"):
		gameManager.ropeCurrentPosition += 1

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("Jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("Left", "Right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	move_and_slide()
