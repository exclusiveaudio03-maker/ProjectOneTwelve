extends Node
class_name CameraShake
# call shake(amount, duration)
func shake(amount, duration):
    var cam = get_viewport().get_camera_3d()
    if not cam: return
    var t = 0.0
    var original = cam.transform
    while t < duration:
        var dx = (randf()-0.5) * amount
        var dy = (randf()-0.5) * amount
        cam.translate_object_local(Vector3(dx, dy, 0))
        yield(get_tree().create_timer(0.02),'timeout')
        t += 0.02
    cam.transform = original
