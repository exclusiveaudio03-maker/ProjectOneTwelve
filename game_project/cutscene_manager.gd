extends Node
class_name CutsceneManager
# Very simple cutscene runner: list of {"type":"dialog"/"wait"/"event", "data":...}
var timeline = []
var index = 0
func play(tl):
    timeline = tl
    index = 0
    _next()
func _next():
    if index >= timeline.size():
        emit_signal('cutscene_finished')
        return
    var entry = timeline[index]
    index += 1
    if entry.type == 'dialog':
        # show dialog via UI (hook up in game)
        print('[CUTSCENE DIALOG] %s: %s' % [entry.data.get('speaker',''), entry.data.get('text','')])
        call_deferred('_next')
    elif entry.type == 'wait':
        var t = entry.data.get('seconds',1)
        yield(get_tree().create_timer(t),'timeout')
        _next()
    elif entry.type == 'event':
        # custom event (placeholder)
        print('[CUTSCENE EVENT] %s' % [entry.data])
        call_deferred('_next')


func play_json(path):
    # loads a cutscene JSON and plays it via timeline
    if not FileAccess.file_exists(path):
        print("Cutscene JSON not found:", path)
        return
    var data = FileAccess.get_file_as_string(path)
    var parsed = JSON.parse_string(data)
    if parsed.error != OK:
        print("Failed to parse cutscene JSON:", parsed.error)
        return
    var obj = parsed.result
    if obj.has("scenes"):
        play(obj.scenes)
