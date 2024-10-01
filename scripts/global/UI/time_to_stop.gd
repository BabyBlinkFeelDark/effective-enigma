extends Node
@onready var lvl_up_menu = $CanvasLayer/LevelUp
func _process(delta: float) -> void:
	if GlobalValue.game_paused:
		get_tree().paused = true
		lvl_up_menu.show()
	else:
		lvl_up_menu.hide()
		get_tree().paused = false
