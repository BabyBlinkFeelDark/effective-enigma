extends Node

signal enemydie(_pos: Vector2)
signal shoot (pos: Vector2,rot:float)
var player_position: Vector2
var is_enemy: bool
var on_spawn_enemy: bool = true
var player_exp: int = 0
var enemyCanMove: bool = true
var max_health: int = 100
var health: int = 100
var mouse_angle: float
var mouse_dir: Vector2
var need_player_exp: int = 100
var game_paused: bool = false
var count_balls: int = 0
var damage: int = 20
var rot_speed: float = 2

func _ready() -> void:
	player_exp = need_player_exp
	pass 


func _process(_delta: float) -> void:
	if player_exp>need_player_exp:
		game_paused = true	
	pass
