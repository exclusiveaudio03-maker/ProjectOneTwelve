extends Node3D
func play(pos):
    var scene_path = 'res://scenes/vfx/dash_trail.tscn'
    if ResourceLoader.exists(scene_path):
        var s = load(scene_path).instantiate()
        s.translation = pos
        get_tree().get_current_scene().add_child(s)
        var p = s.get_node('Particles')
        if p:
            p.emitting = true
            # queue free after lifetime
            s.call_deferred('queue_free')
    else:
        print('Spark at', pos)
