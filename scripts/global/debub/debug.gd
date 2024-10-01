extends Node2D
var player: Player
var is_debug: bool = false
var i
@onready var fire_ball: FireBall
@onready var knight: EnemyKnight
@onready var level: Level

func _process(delta: float) -> void:
	$VBoxContainer/Spawn.set_text("On spawn enemy: " + str(GlobalValue.on_spawn_enemy))
	$VBoxContainer/ExpPoints.set_text("Exp: " + str(GlobalValue.player_exp))
	$VBoxContainer/EnemiesCanMove.set_text("Can Move: " + str(GlobalValue.enemyCanMove))
	$VBoxContainer/Progress.set_text("Progress state: " + str(owner.progress_state))
	if Input.is_action_just_pressed("debug_menu"):
		is_debug =!is_debug
	if is_debug:
		visible=true
	else: 
		visible=false
	if Input.is_action_just_pressed("Num_1") and is_debug:
		for i in range (0,1):
			owner.spawn_knight()
	if Input.is_action_just_pressed("Num_2") and is_debug:	
		GlobalValue.on_spawn_enemy = !GlobalValue.on_spawn_enemy
	if Input.is_action_just_pressed("Num_3") and is_debug:	
		GlobalValue.player_exp+=10
	if Input.is_action_just_pressed("Num_4") and is_debug:
		GlobalValue.enemyCanMove = !GlobalValue.enemyCanMove	
	if Input.is_action_just_pressed("Num_5") and is_debug:
		$MagicEffects.count_ball+=1
