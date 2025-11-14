extends Node
class_name ParrySystem
# Call attempt_parry(window_seconds, attacker)
func attempt_parry(window_seconds, attacker):
    var t = 0.0
    while t < window_seconds:
        if Input.is_action_just_pressed('ui_accept'):
            # successful parry
            if attacker and attacker.has_method('take_damage'):
                attacker.take_damage(10)
            return true
        yield(get_tree().create_timer(0.01),'timeout')
        t += 0.01
    return false
