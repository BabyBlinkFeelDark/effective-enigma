extends Node2D
var player

func _ready() -> void:
	set_as_top_level(true)
	pass 



func _process(delta: float) -> void:
	if player:
		if GlobalValue.player_position:
			position.x = move_toward(position.x, GlobalValue.player_position.x,0.1)
			position.y = move_toward(position.y, GlobalValue.player_position.y, 0.1)		


	pass


func _on_get_point_body_entered(body: Node2D) -> void:
	GlobalValue.player_exp+=50
	queue_free()


func _on_magnet_body_entered(body: Node2D) -> void:
	player=body
