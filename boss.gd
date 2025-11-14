extends CharacterBody3D
var hp := 300
var phase := 1
func _ready():
    pass
func take_damage(amount):
    hp -= amount
    if hp <= 0:
        die()
    elif hp < 200 and phase == 1:
        phase = 2
        # change behaviour placeholder
func die():
    queue_free()
