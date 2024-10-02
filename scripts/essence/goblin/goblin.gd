extends CharacterBody2D
class_name EnemyGoblin
@onready var anim = $AnimatedSprite2D2
@onready var anim_pl = $AnimationPlayer
@onready var navigator = $NavigationAgent2D as NavigationAgent2D
const SPEED = 11000.0
@onready var health = 150
var direction: Vector2
var its_player: bool = false
var attack_cooldown: float = 1.5
var time_since_last_attack: float = 2
var time_to_search: float
var alive: bool = true
var player 
var del
var do_spawn: bool 
var target_position: Vector2
var target_dir: Vector2
enum {
	WALK,
	DEATH,
	HIT,
	GET_DAMAGE
}

var state: int = 0:
	set(value):
		state=value
		match state:
			WALK:
				walk_state(del)
			DEATH:
				death_state()
			HIT:
				hit_state()


func _ready() -> void:
	state = WALK
	pass
func _process(delta: float) -> void:
	del = delta
	time_to_search+=get_process_delta_time()
	target_dir = to_local(navigator.get_next_path_position()).normalized()
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


	if time_to_search>=attack_cooldown/8:
		make_path()
		time_to_search=0
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
	randomize()
	#Перемещение тела к игроку
	if GlobalValue.enemyCanMove:
		if GlobalValue.player_position:
			velocity.x = SPEED * vel_del * target_dir.x
			velocity.y = SPEED * vel_del * target_dir.y	
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
			velocity.y = move_toward(velocity.y, 0, SPEED)
	anim_pl.play("Walk")
	if direction == Vector2(-1, 0):
		anim.play("Walk")
	elif direction == Vector2(1,0):
		anim.play("Walk")
	if direction.x < 0:
		anim.set_flip_h(false)
	elif direction.x > 0:
		anim.set_flip_h(true)
		
	if alive:
		if its_player==true:
			state = HIT
	else:
		do_spawn=true
		state=DEATH


func death_state():
	velocity = Vector2.ZERO
	if do_spawn==true:
		
		GlobalValue.emit_signal("enemydie",position)
		GlobalValue.emit_signal("enemydie",position)
	anim_pl.play("Death")
	do_spawn=false
	queue_free()	

func hit_state():
	anim.play("Attack")
	velocity = Vector2.ZERO
	#Дожидаемся отката кулдауна и наносим удар, вызывая функцию hit
	time_since_last_attack+=get_process_delta_time()
	if time_since_last_attack>=attack_cooldown:
		hit()
		await anim.animation_finished
	if its_player == false:
		state = WALK
	

	
#Фунция нанесения урона игроку	
func hit():
	
	player.health-=7
	time_since_last_attack = 0

func _on_hit_bar_body_entered(body: Node2D) -> void:
	its_player=true
	player = body



func _on_hit_bar_body_exited(body: Node2D) -> void:
	its_player=false

func make_path():
	navigator.target_position = GlobalValue.player_position
