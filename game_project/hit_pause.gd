extends Node
class_name HitPause
var active = false
func pause(seconds):
    if active: return
    active = true
    var orig = Engine.time_scale
    Engine.time_scale = 0.01
    yield(get_tree().create_timer(seconds * 0.01),'timeout')
    Engine.time_scale = orig
    active = false
