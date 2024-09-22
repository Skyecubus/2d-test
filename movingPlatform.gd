extends AnimatableBody2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationPlayer.play("move")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
