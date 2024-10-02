extends ParallaxBackground

var speed_menu = 100
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	scroll_offset.x -= speed_menu * delta
