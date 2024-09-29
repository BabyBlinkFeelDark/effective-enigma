extends Node2D
var inst_ball = 0
var angle_to_rotate: int = 0
var attacks = []
var rotaion_offset
var ball_rotate_velocity = 5
var count_ball=0
var SCENE

func _ready() -> void:
	#Предзагружаем сцену в переменную SCENE
	SCENE = preload("res://scenes/attack/fire_ball.tscn")
	inst_ball = count_ball
	



func _process(delta: float) -> void:
	pass
	#Задаем направление вращения вокруг оси персонажа
	$".".rotation_degrees+=ball_rotate_velocity
	#Если остались незаспавненные шары, то спавним их
	if count_ball!=0:
		spawn_ball()

#########################Не закончено#####################################
	#При нажатии ЛКМ увеличиваем количество шаров на 1
	if Input.is_action_just_pressed("attack"):
		count_ball+=1
		print(count_ball)
		print(attacks)

		
#Функция для спавна шаров		
func spawn_ball():
	if count_ball < 1:
		rotaion_offset = 0
	else:
		#Считаем сектор наждого нового шара
		rotaion_offset = 360/count_ball
	while inst_ball != count_ball:
		var child
		child = SCENE.instantiate()
		#Добавляем шары к списку
		attacks.append(child)
		child.position.x = position.x
		rotation_degrees = angle_to_rotate
		angle_to_rotate += rotaion_offset
		add_child(child)
		inst_ball+=1
	#Отклоняем каждый следующий шар от предыдущего, чтоьбы они находились на равном расстоянии друг от друга
	for i in range(1,len(attacks)):
		attacks[i].rotation_degrees= attacks[i-1].rotation_degrees + rotaion_offset
			
