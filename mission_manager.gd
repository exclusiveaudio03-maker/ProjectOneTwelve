extends Node

var current_mission

func load_mission(file):
    var data = FileAccess.open(file, FileAccess.READ)
    if data:
        current_mission = JSON.parse_string(data.get_as_text())

func objective_complete(id):
    print("Objective", id, "completed")


func spawn_crowd(count, center_pos):
    var gen = preload('res://scripts/npc_generator.gd').new()
    add_child(gen)
    for i in range(count):
        var pos = center_pos + Vector3((randf()-0.5)*6,0,(randf()-0.5)*6)
        gen.spawn(pos)


func start_mission(mission_file):
    if not FileAccess.file_exists(mission_file):
        print("Mission file not found:", mission_file)
        return
    var data = FileAccess.get_file_as_string(mission_file)
    var parsed = JSON.parse_string(data)
    if parsed.error != OK:
        print("Failed to parse mission JSON:", parsed.error)
        return
    current_mission = parsed.result
    # if mission includes a cutscene, play it first
    if current_mission.has("cutscene"):
        var cutscene_path = current_mission.cutscene
        # instantiate CutsceneManager if not present
        var cs = get_node_or_null("/root/CutscenePlayer")
        if not cs:
            var player = load("res://scenes/cutscene_player.tscn").instantiate()
            player.name = "CutscenePlayer"
            get_tree().get_root().add_child(player)
            cs = player
        cs.play_json(cutscene_path)
    else:
        print("No cutscene for mission, starting objectives.")
