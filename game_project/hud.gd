extends CanvasLayer
func _ready():
    $Control/Buttons/LightAttack.pressed.connect(_on_light)
    $Control/Buttons/HeavyAttack.pressed.connect(_on_heavy)
    $Control/Buttons/Dodge.pressed.connect(_on_dodge)
    $Control/Buttons/Finisher.pressed.connect(_on_finisher)
func _on_light():
    var player = get_tree().get_root().get_node("Main/Tutorial/Player")
    if player:
        player.call_deferred("light_attack")
func _on_heavy():
    var player = get_tree().get_root().get_node("Main/Tutorial/Player")
    if player:
        player.call_deferred("heavy_attack")
func _on_dodge():
    var player = get_tree().get_root().get_node("Main/Tutorial/Player")
    if player:
        player.call_deferred("dodge")
func _on_finisher():
    var player = get_tree().get_root().get_node("Main/Tutorial/Player")
    if player:
        player.call_deferred("finisher")
