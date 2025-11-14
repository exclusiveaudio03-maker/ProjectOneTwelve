extends AnimationPlayer

func play_idle():
    play("idle")

func play_attack():
    play("attack")

func play_run():
    if not is_playing() or current_animation != "run":
        play("run")

func play_hurt():
    play("hurt")
