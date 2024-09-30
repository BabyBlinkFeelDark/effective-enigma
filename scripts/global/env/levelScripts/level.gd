extends Node2D
class_name Level

const POINT_SCENE = preload("res://scenes/env/exp_orb.tscn")
const ENEMY_SCENE = preload("res://scenes/essense/enemies/knight.tscn")
var spawn_cooldown: float = 0.2
var time_since_last_spawn_enemy: float = 0 

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	GlobalValue.connect("enemydie", Callable(self, "_on_enemydie"))
	if GlobalValue.on_spawn_enemy:
		time_since_last_spawn_enemy+=get_process_delta_time()
		if time_since_last_spawn_enemy>=spawn_cooldown*10:
			spawn_knight()	
		pass


func spawn_knight():
	var enemy = ENEMY_SCENE.instantiate()
	enemy.global_position = (Vector2(randi_range(-100,100),randi_range(-100,100)))
	add_child(enemy)
	time_since_last_spawn_enemy = 0
	
func spawn_point(pos: Vector2):	
	var point = POINT_SCENE.instantiate()
	point.global_position = pos
	add_child(point)
	
func _on_enemydie(enemi_pos:Vector2):
	print(enemi_pos)
	spawn_point(enemi_pos)
