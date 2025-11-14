extends Node
class_name FinisherCinematic
func play_finisher(target):
    # slow-mo moment
    var orig = Engine.time_scale
    Engine.time_scale = 0.2
    var cam = get_viewport().get_camera_3d()
    # optional camera focus logic (placeholder)
    yield(get_tree().create_timer(0.6),'timeout')
    Engine.time_scale = orig
    if target and target.has_method('take_damage'):
        target.take_damage(999)
