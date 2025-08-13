extends CharacterBody2D

const SPEED = 800.0
const Acceleration = 1000 #Jarryd Added
const friction = 3500 #Jarryd Added
const JUMP_VELOCITY = -500.0

@onready var handL: Marker2D = $PlayerIKBody/CharacterContainer/Body/GBotForearmL/HandL
@onready var handR: Marker2D = $PlayerIKBody/CharacterContainer/Body/GBotForearmR/HandR
@onready var gameManager: Node = $"../../GameManager"

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * 2 * delta #changed gravity

	# Handle jump.
	if Input.is_action_just_pressed("Jump1") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("Left1", "Right1")
	if direction:
		velocity.x = move_toward(velocity.x, direction * SPEED, Acceleration * delta)#Jarryd Change
	else:
		velocity.x = move_toward(velocity.x, 0, friction * delta)#Jarryd Change
	
	move_and_slide()
