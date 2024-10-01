extends Node2D
class_name Level

const POINT_SCENE = preload("res://scenes/env/exp_orb.tscn")
const ENEMY_SCENE = preload("res://scenes/essense/enemies/knight.tscn")
const ARROW_SCENE = preload("res://scenes/attack/arrow.tscn")
var spawn_cooldown: float = 0.2
var time_since_last_spawn_enemy: float = 0 
var canSpawn: bool
var progress: float
var progress_state: float = 0

func _process(delta: float) -> void:
	GlobalValue.connect("enemydie", Callable(self, "_on_enemydie"))
	GlobalValue.connect("shoot", Callable(self, "_on_shoot"))
	
	
	#Увеличиваем спавн рэйт каждые 20 секунд
	if progress_state <= 10:
		progress+=get_process_delta_time()
		if progress>20:
			progress_state+=1
			progress=0
	else:
		progress_state=10.5

	
	if GlobalValue.on_spawn_enemy:
		time_since_last_spawn_enemy+=get_process_delta_time()
		if time_since_last_spawn_enemy>=spawn_cooldown*(11-progress_state):
			spawn_knight()	
		pass


func spawn_knight():
	var enemy = ENEMY_SCENE.instantiate()
	enemy.global_position = (Vector2(randi_range(-80,80),randi_range(-80,80)))
	add_child(enemy)
	time_since_last_spawn_enemy = 0


func spawn_arrow(pos:Vector2,rot:float):
	var arrow = ARROW_SCENE.instantiate()
	arrow.position = pos
	arrow.rotation_degrees=rot
	add_child(arrow)


func spawn_point(pos: Vector2):	
	if canSpawn == true:
		var point = POINT_SCENE.instantiate()
		point.global_position = pos
		add_child(point)
		canSpawn=false
	
func _on_enemydie(enemi_pos:Vector2):
	canSpawn=true
	spawn_point(enemi_pos)
	
func _on_shoot(pos:Vector2,rot:float):
	spawn_arrow(pos,rot)
