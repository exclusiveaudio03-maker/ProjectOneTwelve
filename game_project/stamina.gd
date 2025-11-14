extends Node
class_name StaminaSystem
var max_stamina := 100
var stamina := 100
var regen_rate := 8.0
func use(amount):
    if stamina < amount: return false
    stamina -= amount
    return true
func _process(delta):
    stamina = min(max_stamina, stamina + regen_rate * delta)
