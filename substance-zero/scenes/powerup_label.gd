extends Label


func show_text(_text: String) -> void:
	text = _text
	$Timer.start()




func _on_timer_timeout() -> void:
	text = ""
