extends Node2D

const ENEMY_SCENE = preload("res://scenes/essense/enemies/knight.tscn")
var spawn_cooldown: float = 0.2
var time_since_last_spawn_enemy: float = 0 

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	time_since_last_spawn_enemy+=get_process_delta_time()
	if time_since_last_spawn_enemy>=spawn_cooldown*100:
		spawn_knight()	
	pass


func spawn_knight():
	var enemy = ENEMY_SCENE.instantiate()
	enemy.global_position = (Vector2(randi_range(-100,100),randi_range(-100,100)))
	add_child(enemy)
	time_since_last_spawn_enemy = 0
