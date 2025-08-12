extends RigidBody2D

@export var SPEED: int
@export var JUMPFORCE: int = 50000
var playerIndex

func _ready() -> void:
	var regEx = RegEx.new()
	regEx.compile("\\d+$")
	
	var result = regEx.search(self.name)
	if result:
		playerIndex = int(result.get_string())
		print(playerIndex)

func _physics_process(delta: float) -> void:
	var direction = Input.get_axis("Left" + str(playerIndex), "Right" + str(playerIndex))
	var moveDir = Vector2(direction,0)
	
	if moveDir:
		self.apply_force(moveDir * SPEED * delta)
	#else:
		#self.apply_force(Vector2(-self.linear_velocity.x,0) * 10000 * delta)
	
	self.linear_velocity.x = clampf(self.linear_velocity.x, -500, 500)


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("Jump" + str(playerIndex)):
		apply_impulse(Vector2.UP * JUMPFORCE)
