extends RigidBody2D

class_name FireBall

var enemy


func _ready() -> void:
	pass 



func _process(_delta: float) -> void:
	
	#Делаем проверку, существует ли сущность, чтобы избавиться от ошибки, когда enemy.health == Nill
	while GlobalValue.is_enemy == true and is_instance_valid(enemy):
		enemy.health-=GlobalValue.damage
		#print(enemy.health)
		GlobalValue.is_enemy = false
		


func _on_area_2d_body_entered(body: Node2D) -> void:
	#Говорим что тело body вошло в зону
	GlobalValue.is_enemy = true
	#Присваиваем ссылку на тело локальной переменной enemy
	enemy = body


func _on_area_2d_body_exited(_body: Node2D) -> void:
	#Говорим что тело body вышло из зоны
	GlobalValue.is_enemy = false
