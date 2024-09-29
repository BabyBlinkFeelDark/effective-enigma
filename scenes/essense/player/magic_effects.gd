extends Node2D
var inst_ball = 0
var angle_to_rotate: int = 0
var attacks = []
var rotaion_offset
var ball_rotate_velocity = 5
var count_ball=0
var SCENE
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SCENE = preload("res://scenes/attack/fire_ball.tscn")
	inst_ball = count_ball
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	$".".rotation_degrees+=ball_rotate_velocity
	if count_ball!=0:
		spawn_ball()


	if Input.is_action_just_pressed("attack"):
		count_ball+=1
		print(count_ball)
		print(attacks)

		
		
func spawn_ball():
	if count_ball < 1:
		rotaion_offset = 0
	else:
		rotaion_offset = 360/count_ball
	while inst_ball != count_ball:
		var child
		child = SCENE.instantiate()
		attacks.append(child)
		child.position.x = position.x
		rotation_degrees = angle_to_rotate
		angle_to_rotate += rotaion_offset
		add_child(child)
		inst_ball+=1
	for i in range(1,len(attacks)):
		attacks[i].rotation_degrees= attacks[i-1].rotation_degrees + rotaion_offset
			
