extends CharacterBody3D
var hp := 60
var speed := 3.0
var state := 'patrol'
var target = null
func _ready():
    set_physics_process(true)
func _physics_process(delta):
    if not target:
        target = get_node_or_null('/root/Main/Tutorial/Player')
    if not target: return
    var dir = (target.global_transform.origin - global_transform.origin)
    var dist = dir.length()
    if state == 'patrol':
        # simple idle wander
        translate(Vector3(0,0,0) * delta)
        if dist < 10: state = 'engage'
    elif state == 'engage':
        if dist > 6:
            translate(dir.normalized() * speed * delta)
        else:
            # choose to flank or retreat randomly
            if randi()%2 == 0:
                translate((dir.rotated(Vector3.UP,0.8)).normalized() * speed * delta)
            else:
                translate((-dir).normalized() * (speed*0.5) * delta)
    # react to low health
    if hp < 20 and state != 'flee':
        state = 'flee'
    if state == 'flee':
        translate((-dir).normalized() * (speed*1.2) * delta)
func take_damage(amount):
    hp -= amount
    if hp <= 0:
        queue_free()


func attack_player(target):
    # telegraph then attack
    telegraph_flash()
    yield(get_tree().create_timer(0.4),'timeout')
    if target and target.has_method('take_damage'):
        target.take_damage(10)
        # react to parry possibility
        # (if player parries, they call attempt_parry externally)

func telegraph_flash():
    # placeholder for VFX: print and small camera shake
    print('Enemy telegraphing')
    var cam = get_viewport().get_camera_3d()
    if cam:
        cam.translate_object_local(Vector3(0,0,0))
