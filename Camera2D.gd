extends Camera2D
var topDefault = -583

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var playerHeight = get_parent().position.y 
	if playerHeight < -483:
		limit_top = playerHeight - 100
	else:
		limit_top = topDefault
