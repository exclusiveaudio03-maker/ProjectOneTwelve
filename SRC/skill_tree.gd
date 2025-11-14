extends Node
class_name SkillTree
var skills = {}
func _ready():
    # Example skill nodes
    skills['shadow_strike'] = {'unlocked': false, 'cost': 5, 'level':0}
    skills['adrenal_surge'] = {'unlocked': false, 'cost': 8, 'level':0}
func unlock(skill_key):
    if skills.has(skill_key):
        skills[skill_key]['unlocked'] = true
func is_unlocked(skill_key):
    return skills.has(skill_key) and skills[skill_key]['unlocked']
