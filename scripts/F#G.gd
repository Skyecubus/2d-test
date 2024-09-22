extends CharacterBody2D

const FLOOR_NORMAL = Vector2.UP


@export var speed = 300.0
@export var walkSpeed = 300.0
@export var runSpeed = 500.0
const DASH_SPEED = 1100.0
const MAX_SPEED = 700.0
const WALK_JUMP_VELOCITY = -550.0
const RUN_JUMP_VELOCITY = -850.0
var airDashReady = true
var totalJumps = 0
signal isMoving
@export var jumpsLeft = totalJumps

var dashTimer

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _ready():
	dashTimer = get_node("DashTimer")
	
	if GameVars.doubleJumpAcquired:
		totalJumps = 1
	

func _physics_process(delta):
	#this shit does the sliding on hills stuff
	if is_on_floor():
		set_floor_snap_length(10)
		set_floor_max_angle(1.5)
	elif !is_on_floor():
		set_floor_snap_length(5)
		set_floor_max_angle(0.785398)
		apply_floor_snap()
	move_and_slide()
	
	if is_on_floor(): 
		airDashReady = true
	
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("Jump") and is_on_floor():
		if speed > walkSpeed:
			velocity.y = RUN_JUMP_VELOCITY
		else:
			velocity.y = WALK_JUMP_VELOCITY
		
	
	# handle dash
	if not is_on_floor() and airDashReady and Input.is_action_just_pressed("Run"):
		speed = DASH_SPEED
		gravity = 0
		airDashReady = false
		dashTimer.start()
		
	
	#handle double jump
	#because the character is still touching the floor after the first jump we set 
	#the jump is set to 1 so that for a double jump so that there is 1 jump in the air
	if Input.is_action_just_pressed("Jump") and jumpsLeft > 0 and not is_on_floor():
		velocity.y = WALK_JUMP_VELOCITY
		jumpsLeft -= 1
	
	#reset double jump
	if is_on_floor():
		jumpsLeft = totalJumps
	

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * speed
		isMoving.emit(direction, speed)
		#if you run and jump you will keep run speed
		if Input.is_action_pressed('Run') and is_on_floor():
			speed = runSpeed
	
		#if you walk and jump you will jump with walk speed
		if not Input.is_action_pressed('Run') and is_on_floor():
			speed = walkSpeed
		
			
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
	
	


func doubleJump():
	GameVars.doubleJumpAcquired = true
	totalJumps = 1



func _on_dash_timer_timeout():
	speed = walkSpeed
	gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
	dashTimer.stop()
