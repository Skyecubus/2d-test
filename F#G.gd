extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -500.0
var totalJumps = 0
signal isMoving
@export var jumpsLeft = totalJumps


# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		
	
	#handle double jump
	#because the character is still touching the floor after the first jump we set 
	#the jump is set to 1 so that for a double jump so that there is 1 jump in the air
	if Input.is_action_just_pressed("ui_accept") and jumpsLeft > 0:
		velocity.y = JUMP_VELOCITY
		jumpsLeft -= 1
	
	#reset double jump
	if is_on_floor():
		jumpsLeft = totalJumps
	

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
		isMoving.emit(direction, SPEED)
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	
	move_and_slide()


func doubleJump():
	totalJumps = 1
