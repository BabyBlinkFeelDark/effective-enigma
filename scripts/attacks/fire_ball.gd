extends RigidBody2D
var enemy

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	while GlobalValue.is_enemy == true and is_instance_valid(enemy):
		enemy.health-=50
		print(enemy.health)
		GlobalValue.is_enemy = false
		


func _on_area_2d_body_entered(body: Node2D) -> void:
	GlobalValue.is_enemy = true
	enemy = body


func _on_area_2d_body_exited(body: Node2D) -> void:
	GlobalValue.is_enemy = false
