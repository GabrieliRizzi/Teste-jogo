extends Node

@export var spawn_rate: float = 1.0
@export var enemy_speed: float = 120.0

var _timer := 0.0
var _rng := RandomNumberGenerator.new()

func _process(delta: float) -> void:
    _timer += delta
    if _timer >= spawn_rate:
        _timer = 0.0
        _spawn_enemy()

func _spawn_enemy() -> void:
    var enemy := CharacterBody2D.new()
    var label := Label.new()
    label.text = "X"
    label.position = Vector2(-8, -8)
    enemy.add_child(label)
    enemy.position = Vector2(_rng.randi_range(0, 800), -20)
    enemy.set_physics_process(true)
    enemy.set_script(_create_enemy_script())
    get_tree().current_scene.add_child(enemy)

func _create_enemy_script() -> Script:
    var code := """
extends CharacterBody2D
var speed := %s
func _physics_process(delta):
    velocity = Vector2(0, speed)
    move_and_slide()
    if position.y > 620:
        queue_free()
""" % str(enemy_speed)
    var s := GDScript.new()
    s.source_code = code
    s.reload()
    return s
