extends CharacterBody3D

var hp := 300
var speed := 2.5
var phase := 1
var attack_cooldown := 2.0
var attack_timer := 0.0

func _physics_process(delta):
    attack_timer -= delta
    var player = get_node_or_null("/root/Main/Tutorial/Player")
    if not player:
        return
    var dir = (player.global_transform.origin - global_transform.origin)
    if dir.length() > 3:
        translate(dir.normalized() * speed * delta)
    else:
        if attack_timer <= 0:
            attack(player)
            attack_timer = attack_cooldown

func attack(player):
    if player.has_method("take_damage"):
        player.take_damage(15)

func take_damage(amount):
    hp -= amount
    if hp <= 0:
        die()
    elif hp <= 150 and phase == 1:
        phase = 2
        speed = 4.0
        attack_cooldown = 1.0

func die():
    queue_free()


func telegraph():
    print("Boss telegraphs attack!")


func attack(player):
    # telegraph and heavy hit
    telegraph()
    yield(get_tree().create_timer(0.6),'timeout')
    if player and player.has_method('take_damage'):
        player.take_damage(25)
        # camera shake and pause
        var camshake = preload('res://scripts/camera_shake.gd').new()
        add_child(camshake)
        camshake.shake(0.12,0.25)
        var hp = preload('res://scripts/hit_pause.gd').new()
        add_child(hp)
        hp.pause(0.06)
