extends CharacterBody2D

const SPEED = 1000
const SprintSpeed = 1600
const Acceleration = 1200 #Jarryd Added
const friction = 3500 #Jarryd Added
const JUMP_VELOCITY = -900

#++++++++++++Assigning Player Controls from a resource +++++++++++++++++++++++++
@export var controls: Resource = null
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


#------------Jumping Test Concept-----------------------------------------------
var canJump: bool = false
#-------------------------------------------------------------------------------

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * 2 * delta #changed gravity
		var grav = get_gravity()
		
		#Keeps player from gaining infinite speed downward 
		velocity.y = clamp(velocity.y, grav.y * -2, grav.y * 2)

	
	#--------------Annotated out for test--------------------------------------
	# Handle jump.
	#if Input.is_action_just_pressed("Jump1") and is_on_floor():
		#velocity.y = JUMP_VELOCITY
	#--------------------------------------------------------------------------
	
	#----------------Jump Test Logic-------------------------------------------
	if is_on_floor() and canJump == false:       #Lets player jump once even if
		canJump = true                           #ground isnt under them
	
	if Input.is_action_just_pressed(controls.jump) and canJump:
		velocity.y = JUMP_VELOCITY
		canJump = false
	#--------------------------------------------------------------------------
	
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis(controls.left, controls.right)
	if direction:
		#Check if the player's direction input and current velocity are opposite of each other
		#If so apply friction to the player (This could be done in 2 lines, not sure how right now)
		#------------------------------Braking Addition-------------------------
		if direction > 0 and velocity.x < 0: 
			velocity.x = move_toward(velocity.x, 0, friction * delta) 
		elif direction < 0 and velocity.x > 0: 
			velocity.x = move_toward(velocity.x, 0, friction * delta) 
		#-----------------------------------------------------------------------
		velocity.x = move_toward(velocity.x, direction * SPEED, Acceleration * delta)#Jarryd Change
	else:
		velocity.x = move_toward(velocity.x, 0, friction * delta)#Jarryd Change
	
	move_and_slide()
