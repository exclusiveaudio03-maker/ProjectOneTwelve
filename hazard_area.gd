extends Area3D
var damage := 10
func _on_body_entered(body):
    if body.has_method('take_damage'):
        body.take_damage(damage)


func _ready():
    connect('body_entered', Callable(self,'_on_body_entered'))

func _on_body_entered(body):
    if body.has_method('take_damage'):
        body.take_damage(damage)
    # play vfx based on name
    if name.to_lower().find('electric') != -1:
        var s = preload('res://scripts/spark_effect.gd').new()
        add_child(s)
        s.play(global_transform.origin)
    elif name.to_lower().find('fire') != -1:
        var f = preload('res://scripts/flame_effect.gd').new()
        add_child(f)
        f.play(global_transform.origin)


func _on_body_entered(body):
    if body.has_method('take_damage'):
        body.take_damage(damage)
    if name.to_lower().find('electric') != -1:
        var v = preload('res://scenes/vfx/electric_arc.tscn').instantiate()
        v.translation = global_transform.origin
        get_tree().get_current_scene().add_child(v)
        var p = v.get_node('Particles')
        if p: p.emitting = true
    elif name.to_lower().find('fire') != -1:
        var v = preload('res://scenes/vfx/fire_vent_vfx.tscn').instantiate()
        v.translation = global_transform.origin
        get_tree().get_current_scene().add_child(v)
