extends Area2D

signal hit

@export var speed = 400 #pixels/sec
var screen_size # Size of the game Window

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	screen_size = get_viewport_rect().size


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")

	position += direction * speed * delta
	position = position.clamp(Vector2.ZERO, screen_size)

	_update_animation(direction)


func _update_animation(direction: Vector2) -> void:
	var sprite = $AnimatedSprite2D

	if direction == Vector2.ZERO:
		sprite.play("idle")
		return
	
	if abs(direction.x) > abs(direction.y):
		# Horizontal domina → usa walk-right e espelha se for pra esquerda
		sprite.flip_h = direction.x < 0
		sprite.play("walk-right")
	else:
		sprite.play("walk-down" if direction.y > 0 else "walk-up")


func _on_body_entered(body: Node2D) -> void:
	hide()
	hit.emit()
	$CollisionShape2D.set_deferred("disabled", true)


func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false
