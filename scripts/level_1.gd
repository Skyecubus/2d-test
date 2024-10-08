extends Node2D

var doubleJumpBoot 
var player
var camera 
var enemy1
var levelFinished = false


# Called when the node enters the scene tree for the first time.
func _ready():
	doubleJumpBoot = get_node("doubleJumpBoot")
	player = get_node("F#G")
	camera = get_node("Camera2D")
	doubleJumpBoot.connect("pickedUp", player.doubleJump)
	#enemy1 = get_node("KnightEnemy")
	#enemy1.connect("died", deleteEnemy)
	#enemy1.connect("kill", playerDied)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if levelFinished:
		if Input.is_action_just_pressed("Select"):
			level_complete()
	
func playerDied():
	if GameVars.lives <= 0:
		get_tree().change_scene_to_file("res://game_over_screen.tscn")
	else:
		GameVars.lives -= 1
		get_tree().change_scene_to_file("res://level_1_1.tscn")

func level_complete():
	get_tree().change_scene_to_file("res://hub_area.tscn")

func deleteEnemy(enemy):
	enemy.queue_free()


func _on_kill_plane_body_entered(body):
	if body.is_in_group("player"):
		playerDied()
		print("dead")


func _on_knight_enemy_died(entity):
	deleteEnemy(entity)


func _on_knight_enemy_kill():
	playerDied()


func _on_level_finish_body_entered(body):
	levelFinished = true


func _on_level_finish_body_exited(body):
	levelFinished = false
