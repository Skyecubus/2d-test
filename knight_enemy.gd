extends CharacterBody2D

signal died
signal kill

const SPEED = -1.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready(): 
	get_node("AnimatedSprite2D").play()

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	#velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	
	position.x += SPEED

	move_and_slide()


func _on_hurt_box_body_entered(body):
	if body.is_in_group("player"):
		died.emit(self)


func _on_hitbox_body_entered(body):
	if body.is_in_group("player"):
		kill.emit()
