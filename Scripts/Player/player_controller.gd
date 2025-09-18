extends CharacterBody2D
class_name Player

@export var SPEED = 1000
@export var SprintSpeed = 1600
@export var Acceleration = 1200 #Jarryd Added
@export var friction = 3500 #Jarryd Added
@export var JUMP_VELOCITY = -900


#^^^^^^^^^^^^^^^^^^^^^^^^^^^^Animation Variables^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
@export var AnimTree: AnimationTree
@export var AnimPlayer: AnimationPlayer
@export var IKBody: Node2D
#^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

#++++++++++++Assigning Player Controls from a resource +++++++++++++++++++++++++
@export var controls: Resource = null
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


#------------Jumping Variable---------------------------------------------------
var canJump: bool = false
var MaxJump: int = 1
var JumpNum: int = 0
#-------------------------------------------------------------------------------

#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$Confusion Logic$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
# 1 = Standard Controls, -1 = Reversed
var confusion: int = 1
#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$


#/-/-/-/-/-/-/-/-/-/-/-/-/-/-/Stun Logic/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/
var IsStunned: bool
#100 = 1 Sec
var MaxStun: int = 200
var CurrentStun: int
@export var KnockbackDir: int
#/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/

func _ready() -> void:
	IsStunned = false
	CurrentStun = MaxStun
	
	ResetAnimations()


func _physics_process(delta: float) -> void:
		# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * 2 * delta #changed gravity
		var grav = get_gravity()
		
		#Keeps player from gaining infinite speed downward 
		velocity.y = clamp(velocity.y, grav.y * -2, grav.y * 2)
	
	if IsStunned == false:
		PlayerMovement(delta)
	else:
		#Stun degrade logic
		if AnimTree.get("parameters/StateMachine/conditions/Idle") == false:
			ResetAnimations()
		if MaxJump > 1:
			MaxJump = 1
		if CurrentStun == MaxStun:
			Knockback(1000)
		if CurrentStun <= (MaxStun - 10):
			if is_on_floor():
				velocity.x = 0
		CurrentStun = CurrentStun - (1 * delta)
		if CurrentStun <= 0:
			IsStunned = false
			CurrentStun = MaxStun
	
	move_and_slide()

func Knockback(knockbackforce: int):
	self.velocity = Vector2((knockbackforce * KnockbackDir),(-knockbackforce))

func PlayerMovement(delta: float):	
	#----------------------Jump Logic-------------------------------------------
	if is_on_floor() and canJump == false:       #Lets player jump once even if
		canJump = true                           #ground isnt under them
		JumpNum = 0
	
	if Input.is_action_just_pressed(controls.jump) and canJump:
		JumpAnimation()
		velocity.y = JUMP_VELOCITY - 500
		JumpNum += 1
		if JumpNum >= MaxJump:
			canJump = false
	#--------------------------------------------------------------------------
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis(controls.left, controls.right) * confusion
	if direction:
		if is_on_floor():
			if AnimTree.get("parameters/StateMachine/conditions/IsMoving") == false:
				if canJump == true:
					if AnimTree.get("parameters/StateMachine/conditions/IsJumping") == true:
						JumpToWalkAnimation()
					else:
						WalkingAnimation()
		#Check if the player's direction input and current velocity are opposite of each other
		#If so apply friction to the player
		#------------------------------Braking Addition-------------------------
		if direction > 0:
			if IKBody.scale.x < 0:
				IKBody.scale.x *= -1
			if velocity.x < 0: 
				velocity.x = move_toward(velocity.x, 0, friction * delta)
		elif direction < 0: 
			if IKBody.scale.x > 0:
				IKBody.scale.x *= -1
			if velocity.x > 0: 
				velocity.x = move_toward(velocity.x, 0, friction * delta) 
		#-----------------------------------------------------------------------
		velocity.x = move_toward(velocity.x, direction * SPEED, Acceleration * delta)#Jarryd Change
		
		AnimTree.set("parameters/TimeScale/scale", 1 * abs(velocity.x) / 500)
	else:
		velocity.x = move_toward(velocity.x, 0, friction * delta)#Jarryd Change
		if canJump == true:
			ResetAnimations()
			AnimTree.set("parameters/TimeScale/scale", 1)

func ResetAnimations() -> void:
	AnimTree.set("parameters/StateMachine/conditions/Idle", true)
	AnimTree.set("parameters/StateMachine/conditions/IsJumping", false)
	AnimTree.set("parameters/StateMachine/conditions/IsMoving", false)
	AnimTree.set("parameters/StateMachine/conditions/GroundedMoving", false)

func WalkingAnimation() -> void:
	AnimTree.set("parameters/StateMachine/conditions/Idle", false)
	AnimTree.set("parameters/StateMachine/conditions/IsJumping", false)
	AnimTree.set("parameters/StateMachine/conditions/IsMoving", true)
	AnimTree.set("parameters/StateMachine/conditions/GroundedMoving", false)

func JumpAnimation() -> void:
	AnimTree.set("parameters/StateMachine/conditions/Idle", false)
	AnimTree.set("parameters/StateMachine/conditions/IsJumping", true)
	AnimTree.set("parameters/StateMachine/conditions/IsMoving", false)
	AnimTree.set("parameters/StateMachine/conditions/GroundedMoving", false)

func JumpToWalkAnimation() -> void:
	AnimTree.set("parameters/StateMachine/conditions/Idle", false)
	AnimTree.set("parameters/StateMachine/conditions/IsJumping", false)
	AnimTree.set("parameters/StateMachine/conditions/IsMoving", false)
	AnimTree.set("parameters/StateMachine/conditions/GroundedMoving", true)
