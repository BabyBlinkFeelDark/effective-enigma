extends Node
@onready var lvl_up_menu = $CanvasLayer/LevelUp
@onready var pause_menu = $CanvasLayer/Pause
var game_pause_menu: bool = false


func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_cancel"):
		game_pause_menu = !game_pause_menu	
	
	if game_pause_menu == true:
		get_tree().paused = true

		pause_menu.show()
	else:
		pause_menu.hide()
		if GlobalValue.game_paused:
			get_tree().paused = true
			lvl_up_menu.show()

		else:
			lvl_up_menu.hide()
			get_tree().paused = false
