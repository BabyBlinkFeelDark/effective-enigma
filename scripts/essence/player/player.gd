extends CharacterBody2D
class_name Player


enum {
	WALK,
	DEATH,
	ATTACK
}


const SPEED = 150.0
@onready var anim = $AnimatedSprite2D
@onready var anim_pl = $AnimatedSprite2D
var health: int = 100
var exp: int = 0
var emit_xp: int
var state = WALK
var player_pos: Vector2
var player: Vector2



func _ready() -> void:
	pass
		
func _physics_process(delta: float) -> void:
	
	$Debug/VBoxContainer/Health.set_text(str(health))
	match state:
		WALK:
			walk_state(delta)
		DEATH:
			death_state()
		ATTACK:
			attack_state()
	move_and_slide()
	

func walk_state(vel_del):
	GlobalValue.player_position = position
	var direction : Vector2
	direction.x = Input.get_axis("left", "right")
	direction.y = Input.get_axis("up", "down")
	
	
	#Передвижение
	if direction:
		velocity = Vector2(direction.x * SPEED,direction.y*SPEED) 
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.y = move_toward(velocity.y, 0, SPEED)

	if Input.is_action_just_pressed("attack"):
		state = ATTACK	
		
	#Смена анимации в зависимости от вектора направления Direction
	if direction.x == -1:
		anim.flip_h=true
	elif direction.x == 1: 
		anim.flip_h=false
	if direction.y<0:
		if direction.x!=0: 
			anim_pl.play("walk_up_side")
		elif direction.x==0: 
			anim_pl.play("walk_up")
	elif direction.y>0:
		if direction.x!=0: 
			anim_pl.play("walk_down_side")
		elif direction.x==0:
			anim_pl.play("walk_down")
	elif direction.y==0 and direction.x!=0:
		anim_pl.play("walk_side")
	elif direction==Vector2.ZERO:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.y = move_toward(velocity.y, 0, SPEED)
		anim.play("idle")
	

	
	if health<=0:
		state=DEATH

#########################Не закончено#####################################
func attack_state():
	#print("hello")
	state = WALK
	pass

#########################Не закончено#####################################
func death_state():
	anim_pl.play("death")
	queue_free()
	#get_tree(). change_scene_to_file("res://scene/menu.tscn")
		
