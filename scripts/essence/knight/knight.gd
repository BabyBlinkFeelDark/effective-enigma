extends CharacterBody2D

@onready var anim = $AnimatedSprite2D2

const SPEED = 100.0
var state
@onready var health = 100
var direction: Vector2
var its_player: bool = false
var attack_cooldown: float = 2.0
var time_since_last_attack: float = 2
var alive: bool = true


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
	if health<0:
		alive=false
	match state:
		WALK:
			walk_state(delta)
		DEATH:
			death_state()
		HIT:
			hit_state()
		GET_DAMAGE:
			damage_state()
			
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
	

	#if GlobalValue.player_position:
		#position.x = move_toward(position.x, player.position.x, SPEED*vel_del)
		#position.y = move_toward(position.y, player.position.y, SPEED*vel_del)		
	#else:
		#velocity.x = move_toward(velocity.x, 0, SPEED)
		#velocity.y = move_toward(velocity.y, 0, SPEED)
	if alive:
		if its_player==true:
			state = HIT
	else:
		state=DEATH
	#anim.play("walk_down")


		
func death_state():
	#print(health)
	death()
	pass
	#await $AnimationPlayer.animated_finished
	queue_free()


func hit_state():
	#anim.play("down_attack")
	time_since_last_attack+=get_process_delta_time()
	if time_since_last_attack>=attack_cooldown:
		hit()
	if its_player == false:
		state = WALK
	
	
func damage_state():
	print(health)
	if health<=0:
		state = DEATH
	state = WALK
	
		
func hit():
	#player.health-=1
	time_since_last_attack = 0


func get_dmg():
	pass
		
func _on_hit_boxes_body_entered(body: Node2D) -> void:
	its_player=true


func _on_hit_boxes_body_exited(body: Node2D) -> void:
	its_player=false
	
func death():
	$AnimationPlayer.play("death")
	
