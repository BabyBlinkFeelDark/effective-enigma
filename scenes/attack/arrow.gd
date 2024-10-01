extends RigidBody2D
var enemy
var damage:int = 1000
var count = 0
var time_since_last:float = 0
var time_to_life: float = 1.0


func _ready() -> void:
	pass


func _physics_process(delta: float) -> void:
	position +=Vector2(GlobalValue.mouse_dir.x, GlobalValue.mouse_dir.y)/5
	time_since_last+=get_process_delta_time()
	if time_since_last>=time_to_life:
		queue_free()
		count = 0
	while GlobalValue.is_enemy == true and is_instance_valid(enemy):
		enemy.health-=damage
		GlobalValue.is_enemy = false
		


func _on_area_2d_body_entered(body: Node2D) -> void:
	#Говорим что тело body вошло в зону
	GlobalValue.is_enemy = true
	count+=1
	if count == 3 or time_since_last>=time_to_life:
		queue_free()
		count = 0
	#Присваиваем ссылку на тело локальной переменной enemy
	enemy = body


func _on_area_2d_body_exited(body: Node2D) -> void:
	#Говорим что тело body вышло из зоны
	GlobalValue.is_enemy = false
