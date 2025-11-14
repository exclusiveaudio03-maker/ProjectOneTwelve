extends Node3D
func play(pos):
    var scene_path = 'res://scenes/vfx/fire_vent_vfx.tscn'
    if ResourceLoader.exists(scene_path):
        var s = load(scene_path).instantiate()
        s.translation = pos
        get_tree().get_current_scene().add_child(s)
    else:
        print('Flame burst at', pos)
