extends Node2D

var attack_cooldown: float = 0.5
var time_since_last_attack: float = 20
func _ready() -> void:

	pass 



func _process(delta: float) -> void:
	rotation_degrees = GlobalValue.mouse_angle
	time_since_last_attack+=get_process_delta_time()
	if Input.is_action_just_pressed("attack"):
		if time_since_last_attack>=attack_cooldown:
			GlobalValue.emit_signal("shoot",$Marker2D.global_position,rotation_degrees)
			time_since_last_attack = 0 
		pass



		
		
