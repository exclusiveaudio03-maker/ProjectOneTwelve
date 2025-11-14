extends Node3D
func _ready():
    var tut = load("res://scenes/tutorial.tscn").instantiate()
    tut.name = "Tutorial"
    add_child(tut)


func _ready():
    # instantiate tutorial and then start mission via mission manager
    var tut = load("res://scenes/tutorial.tscn").instantiate()
    tut.name = "Tutorial"
    add_child(tut)
    # start mission
    var mm = get_node_or_null("/root/MissionManager")
    if not mm:
        var mgr = load("res://scripts/mission_manager.gd").new()
        mgr.name = "MissionManager"
        get_tree().get_root().add_child(mgr)
        mm = mgr
    mm.start_mission('data/mission_initiation_protocol.json')
