extends Control
signal restart_requested
func _input(event):
    if event.is_action_pressed("ui_accept"):
        emit_signal("restart_requested")
