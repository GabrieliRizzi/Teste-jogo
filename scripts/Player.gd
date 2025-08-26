extends CharacterBody2D

@export var speed: float = 300.0

func _physics_process(delta: float) -> void:
    var input_vector = Vector2.ZERO
    input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
    input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
    velocity = input_vector.normalized() * speed
    move_and_slide()
