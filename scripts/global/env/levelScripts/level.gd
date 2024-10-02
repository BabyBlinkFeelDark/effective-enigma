extends Node2D
class_name Level

const POINT_SCENE = preload("res://scenes/env/exp_orb.tscn")
const KNIGHT_SCENE = preload("res://scenes/essense/enemies/knight.tscn")
const ARROW_SCENE = preload("res://scenes/attack/arrow.tscn")
const GOBLIN_SCENE = preload("res://scenes/essense/enemies/goblin.tscn")
const PRELOADED_ENEMIES ={
"knight": KNIGHT_SCENE, 
"goblin": GOBLIN_SCENE}
var spawn_cooldown: float = 0.2
var time_since_last_spawn_enemy: float = 0 
var canSpawn: bool
var progress: float
var progress_state: int = 8
var spawned_entities = []
var enemies_rate = {
	0: {"knight": 100, "goblin": 0, "EnemyC": 0},
	1: {"knight": 70, "goblin": 30, "EnemyC": 0},
	2: {"knight": 50, "goblin": 30, "EnemyC": 0},
	3: {"knight": 40, "goblin": 40, "EnemyC": 0},
	4: {"knight": 30, "goblin": 70, "EnemyC": 0},
	5: {"knight": 70, "goblin": 30, "EnemyC": 0},
	6: {"knight": 50, "goblin": 50, "EnemyC": 0},
	7: {"knight": 50, "goblin": 50, "EnemyC": 0},
	8: {"knight": 50, "goblin": 50, "EnemyC": 0},
	9: {"knight": 50, "goblin": 50, "EnemyC": 0},
	10: {"knight": 50, "goblin": 50, "EnemyC": 0}
}


func _process(delta: float) -> void:
	var ratios
	var random_value = randi_range(0,100)
	var cumulative = 0

	randomize()
	
	if progress_state < 10:
		progress+=get_process_delta_time()
		if progress>20:
			progress_state+=1
			progress=0
	else:
		progress_state=10

	ratios = enemies_rate[progress_state]
	spawned_entities = spawned_entities.filter(is_instance_valid)
	if GlobalValue.on_spawn_enemy:
		time_since_last_spawn_enemy+=get_process_delta_time()
		for enemy_type in ratios.keys():
			cumulative += ratios[enemy_type]
			if random_value < cumulative:
				if time_since_last_spawn_enemy>=spawn_cooldown*(10.5-progress_state) and spawned_entities.size()<100:
					spawn_enemies(PRELOADED_ENEMIES[enemy_type])
				break
		
	GlobalValue.connect("enemydie", Callable(self, "_on_enemydie"))
	GlobalValue.connect("shoot", Callable(self, "_on_shoot"))
	print("count: ", spawned_entities.size())
	progressing(progress_state)

func spawn_enemies(_scene):
	var enemy = _scene.instantiate()
	enemy.global_position = (Vector2(randi_range(-800,800),randi_range(-800,800)))
	spawned_entities.append(enemy)
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


func progressing(_state: int):
	match _state:
		0:
			enemies_rate["knight"] = 100

		1:
			enemies_rate["knight"] = 90
			enemies_rate["goblin"] = 10

		2:
			enemies_rate["knight"] = 80
			enemies_rate["goblin"] = 20
		3:
			enemies_rate["knight"] = 60
			enemies_rate["goblin"] = 40
		4:
			enemies_rate["knight"] = 50
			enemies_rate["goblin"] = 50
		5:
			enemies_rate["knight"] = 30
			enemies_rate["goblin"] = 70
		6:
			enemies_rate["knight"] = 20
			enemies_rate["goblin"] = 80
		7:
			enemies_rate["knight"] = 10
			enemies_rate["goblin"] = 90
		8:
			enemies_rate["knight"] = 0
			enemies_rate["goblin"] = 100
		9:
			enemies_rate["goblin"] = 100
		10:
			enemies_rate["goblin"] = 100
