extends Node

signal enemydie(_pos: Vector2)
signal shoot (pos: Vector2,rot:float)
var player_position: Vector2
var is_enemy: bool
var on_spawn_enemy: bool = true
var player_exp: int = 0
var enemyCanMove: bool = true
var max_health: int = 100
var health: int 
var mouse_angle: float
var mouse_dir: Vector2

func _ready() -> void:
	pass 


func _process(delta: float) -> void:
	
	pass
