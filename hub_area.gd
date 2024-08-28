extends Node2D
var level = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		if level == 1:
			get_tree().change_scene_to_file("res://level_1.tscn")



func _on_level_one_entrance_body_entered(body):
	level = 1


func _on_level_one_entrance_body_exited(body):
	level = 0
