extends Control
var bonuses = {
	"+20 Health": GlobalValue.health,
	"+25% Rotation Velocity": GlobalValue.rot_speed,
	"+1 Number of balls" : GlobalValue.count_balls,
	"+25% Damage": GlobalValue.damage
}
@onready var button1 = $Panel/HBoxContainer/Button
@onready var button2 = $Panel/HBoxContainer/Button2
@onready var button3 = $Panel/HBoxContainer/Button3


var hui = ["clen", "bolt", "penis"]
var target = ["bolt"]
var i: int = 3
var random_key = []

func _ready() -> void:
	pass



func _process(delta: float) -> void:
	
	var buttons = [button1, button2, button3]

	randomize_bonuses(random_key)
	for i in range (0,3):
		buttons[i].set_text(random_key[i])

	pass
	
	
func randomize_bonuses(_array):
	randomize()
	var bonus = bonuses.keys()
	var random_index
	var exceptions = []
	while i>0:
		random_index = randi_range(0, bonuses.size()-1)
		if not _array.has(bonus[random_index]):
			_array.append(bonus[random_index]) 
			i-=1
		print(_array)


func switch_bonus(_index:int):
	match random_key[_index]:
		"+20 Health":
			GlobalValue.health+=20
		"+25% Rotation Velocity": 
			GlobalValue.rot_speed*=1.25
		"+1 Number of balls":
			GlobalValue.count_balls+=1
		"+25% Damage":
			GlobalValue.damage*=1.25
			
			
func _on_button_pressed() -> void:
	i=3
	GlobalValue.game_paused=false
	GlobalValue.need_player_exp*=1.2
	GlobalValue.player_exp=0
	switch_bonus(0)
	random_key.clear()	


func _on_button_2_pressed() -> void:
	i=3
	GlobalValue.game_paused=false
	GlobalValue.need_player_exp*=1.2
	GlobalValue.player_exp=0
	switch_bonus(1)
	random_key.clear()

	
func _on_button_3_pressed() -> void:
	i=3
	GlobalValue.game_paused=false
	GlobalValue.need_player_exp*=1.2
	GlobalValue.player_exp=0
	switch_bonus(2)
	random_key.clear()	
