extends Node
class_name NPCGenerator
var npc_scene = null
func _ready():
    # look for a PackedScene at res://scenes/npc.tscn if present
    if ResourceLoader.exists('res://scenes/npc.tscn'):
        npc_scene = load('res://scenes/npc.tscn')
func spawn(position):
    if not npc_scene: return null
    var n = npc_scene.instantiate()
    n.global_transform.origin = position
    get_tree().get_current_scene().add_child(n)
    return n
