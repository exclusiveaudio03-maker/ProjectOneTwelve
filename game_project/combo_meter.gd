extends Label
var combo := 0
func add_combo():
    combo += 1
    text = "Combo: %s" % combo
func reset_combo():
    combo = 0
    text = "Combo: 0"
