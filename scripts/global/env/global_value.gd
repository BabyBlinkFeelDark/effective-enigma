extends Node

signal enemydie (_player_pos: Vector2)
var player_position: Vector2
var is_enemy: bool
var on_spawn_enemy: bool = true
var player_exp: int = 0
var enemyCanMove: bool = true
var max_health: int = 100
var health: int 


func _ready() -> void:
	pass 


func _process(delta: float) -> void:
	pass
