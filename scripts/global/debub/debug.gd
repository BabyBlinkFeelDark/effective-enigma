extends Node2D
var player: Player
var is_debug: bool = false
var i
@onready var fire_ball: FireBall
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("debug_menu"):
		is_debug =!is_debug
	if is_debug:
		visible=true
	else: 
		visible=false
	if Input.is_action_just_pressed("Num_1") and is_debug:
		for i in range (0,10):
			owner.spawn_knight()
	if Input.is_action_just_pressed("Num_2") and is_debug:	
		i=0
	
