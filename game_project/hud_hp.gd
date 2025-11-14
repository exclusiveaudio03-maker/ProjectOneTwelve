extends CanvasLayer

var player
var enemy_list = []

func _ready():
    player = get_tree().get_root().get_node("Main/Tutorial/Player")

func _process(delta):
    if player:
        $Control/PlayerHP.value = player.hp
