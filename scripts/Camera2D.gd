extends Camera2D
var topDefault = -583

# Called when the node enters the scene tree for the first time.
func _ready():
	#this is all of the properties we need to change to get the camera 
	#to move in a pleasing way with the player
	position_smoothing_enabled = true
	position_smoothing_speed = 2
	process_callback = Camera2D.CAMERA2D_PROCESS_PHYSICS


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var playerHeight = get_parent().position.y 
	if playerHeight < -483:
		limit_top = playerHeight - 100
	else:
		limit_top = topDefault
