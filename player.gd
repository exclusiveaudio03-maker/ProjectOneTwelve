extends CharacterBody3D

@export var speed := 6.0
var velocity := Vector3.ZERO
var hp := 100

# integrated systems
var stamina := 100.0
var max_stamina := 100.0
var stamina_regen := 10.0
var invincible := false
var invincible_timer := 0.0

onready var cam_shake = preload("res://scripts/camera_shake.gd").new()
onready var hitpause = preload("res://scripts/hit_pause.gd").new()
onready var finisher_cine = preload("res://scripts/finisher_cinematic.gd").new()
onready var parry_sys = preload("res://scripts/parry.gd").new()

func _ready():
    add_child(cam_shake)
    add_child(hitpause)
    add_child(finisher_cine)
    add_child(parry_sys)

func _physics_process(delta):
    # stamina regen
    stamina = min(max_stamina, stamina + stamina_regen * delta)
    if invincible:
        invincible_timer -= delta
        if invincible_timer <= 0:
            invincible = false

    var input_dir = Vector3.ZERO
    input_dir.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
    input_dir.z = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
    if input_dir.length() > 0:
        input_dir = input_dir.normalized()
        velocity.x = input_dir.x * speed
        velocity.z = input_dir.z * speed
    else:
        velocity.x = move_toward(velocity.x, 0, speed*0.1)
        velocity.z = move_toward(velocity.z, 0, speed*0.1)
    velocity = move_and_slide(velocity, Vector3.UP)

func light_attack():
    if stamina < 5: return
    stamina -= 5
    _apply_area_damage(2,20)

func heavy_attack():
    if stamina < 12: return
    stamina -= 12
    _apply_area_damage(3,35)

func dodge():
    if stamina < 10: return
    stamina -= 10
    invincible = true
    invincible_timer = 0.6
    translate(Vector3(0,0,-1))
    cam_shake.shake(0.06,0.18)

func finisher():
    # require combo or stamina high
    if stamina < 30: return
    stamina -= 30
    # find nearest enemy
    var space = get_world_3d().direct_space_state
    var shape = BoxShape3D.new()
    shape.size = Vector3(4,4,4)
    var param = PhysicsShapeQueryParameters3D.new()
    param.shape_rid = shape.get_rid()
    param.transform = Transform3D(Basis(), global_transform.origin)
    var res = space.intersect_shape(param, 32)
    for hit in res:
        if hit.collider and hit.collider.has_method("take_damage"):
            # play finisher cinematic then kill
            finisher_cine.play_finisher(hit.collider)
            return

func attempt_parry(attacker):
    # 0.3s window
    var ok = parry_sys.attempt_parry(0.3, attacker)
    if ok:
        cam_shake.shake(0.08,0.2)
        hitpause.pause(0.06)
        if attacker and attacker.has_method("take_damage"):
            attacker.take_damage(15)

func _apply_area_damage(size, dmg):
    var space = get_world_3d().direct_space_state
    var shape = BoxShape3D.new()
    shape.size = Vector3(size,size,size)
    var param = PhysicsShapeQueryParameters3D.new()
    param.shape_rid = shape.get_rid()
    param.transform = Transform3D(Basis(), global_transform.origin)
    var res = space.intersect_shape(param, 32)
    for hit in res:
        if hit.collider and hit.collider.has_method("take_damage"):
            hit.collider.take_damage(dmg)
            cam_shake.shake(0.04,0.12)
            hitpause.pause(0.04)


# VFX hooks
func _vfx_dash(pos):
    var p = preload('res://scripts/spark_effect.gd').new()
    p.play(pos)

func _vfx_hit(pos):
    var scene_path = 'res://assets/vfx/hit_flash.tres'
    # instantiate a small particle node
    var p = preload('res://scripts/spark_effect.gd').new()
    p.play(pos)
