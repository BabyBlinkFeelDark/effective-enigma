extends Node2D
var player
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_as_top_level(true)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if player:
		if GlobalValue.player_position:
			position.x = move_toward(position.x, GlobalValue.player_position.x,0.1)
			position.y = move_toward(position.y, GlobalValue.player_position.y, 0.1)		
		#else:
			#velocity.x = move_toward(velocity.x, 0, 10000)
			#velocity.y = move_toward(velocity.y, 0, 10000)

	pass


func _on_get_point_body_entered(body: Node2D) -> void:
	GlobalValue.player_exp+=10
	queue_free()


func _on_magnet_body_entered(body: Node2D) -> void:
	player=body
