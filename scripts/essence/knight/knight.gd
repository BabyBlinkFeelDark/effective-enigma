extends CharacterBody2D
class_name EnemyKnight
@onready var anim = $AnimatedSprite2D2



const SPEED = 100.0
var state
@onready var health = 100
var direction: Vector2
var its_player: bool = false
var attack_cooldown: float = 2.0
var time_since_last_attack: float = 2
var alive: bool = true
var player
var do_spawn: bool 


enum {
	WALK,
	DEATH,
	HIT,
	GET_DAMAGE
}


func _ready() -> void:
	state = WALK
	pass



func _physics_process(delta: float) -> void:
	

		
	
	#Машина состояний для NPC
	if health<=0:
		alive=false
		
	match state:
		WALK:
			walk_state(delta)
		DEATH:
			death_state()
		HIT:
			hit_state()

			
	#Поиск вектора направления 	
	if GlobalValue.player_position:
		if GlobalValue.player_position.x - global_position.x>0:
			direction.x=-1
		elif GlobalValue.player_position.x - global_position.x<0:
			direction.x=1
		if GlobalValue.player_position.y - global_position.y>0:
			direction.y=-1
		elif GlobalValue.player_position.y - global_position.y<0:
			direction.y=1

	
	move_and_slide()
func walk_state(vel_del):

	#Перемещение тела к игроку
	if GlobalValue.enemyCanMove:
		if GlobalValue.player_position:
			position.x = move_toward(position.x, GlobalValue.player_position.x, SPEED*vel_del)
			position.y = move_toward(position.y, GlobalValue.player_position.y, SPEED*vel_del)		
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
			velocity.y = move_toward(velocity.y, 0, SPEED)

	if direction == Vector2(-1,-1):
		anim.play("walk_down")
	elif direction == Vector2(1,1):
		anim.play("walk_up")
		
	if alive:
		if its_player==true:
			state = HIT
	else:
		do_spawn=true
		state=DEATH
	
	
func death_state():
	if do_spawn==true:
		GlobalValue.emit_signal("enemydie",position)
	anim.play("death")
	do_spawn=false
	await anim.animation_finished
	queue_free()
	




func hit_state():

	#Дожидаемся отката кулдауна и наносим удар, вызывая функцию hit
	time_since_last_attack+=get_process_delta_time()
	if time_since_last_attack>=attack_cooldown:
		hit()
	if its_player == false:
		state = WALK
	

	
#Фунция нанесения урона игроку	
func hit():
	anim.play("down_attack")
	player.health-=10

	time_since_last_attack = 0
	

func _on_hit_boxes_body_entered(body: Node2D) -> void:
	its_player=true
	player = body



func _on_hit_boxes_body_exited(body: Node2D) -> void:
	its_player=false
	
	
