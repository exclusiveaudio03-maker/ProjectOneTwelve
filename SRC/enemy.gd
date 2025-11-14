extends CharacterBody3D
var hp := 50
var speed := 3.0
func _ready():
    set_physics_process(true)
func _physics_process(delta):
    var player = get_node_or_null("/root/Main/Tutorial/Player")
    if player:
        var dir = (player.global_transform.origin - global_transform.origin)
        if dir.length() > 1.5:
            dir = dir.normalized()
            translate(dir * speed * delta)
func take_damage(amount):
    hp -= amount
    if hp <= 0:
        queue_free()
