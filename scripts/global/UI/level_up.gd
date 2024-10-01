extends Control
var around_attack: MagicEffects

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	print(GlobalValue.game_paused)
	pass


func _on_button_pressed() -> void:
	GlobalValue.health=100
	GlobalValue.count_balls+=1
	GlobalValue.game_paused=false
	GlobalValue.need_player_exp*=1.2
	GlobalValue.player_exp=0
	


func _on_button_2_pressed() -> void:
	GlobalValue.damage*=1.25
	GlobalValue.game_paused=false
	GlobalValue.need_player_exp*=1.2
	GlobalValue.player_exp=0
	GlobalValue.health+=20

func _on_button_3_pressed() -> void:
	GlobalValue.rot_speed*=1.25
	GlobalValue.game_paused=false
	GlobalValue.need_player_exp*=1.2
	GlobalValue.player_exp=0
	GlobalValue.health+=20
