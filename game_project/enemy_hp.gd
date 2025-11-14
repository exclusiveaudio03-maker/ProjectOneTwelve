extends ProgressBar
var enemy_ref
func _process(delta):
    if enemy_ref:
        value = enemy_ref.hp
