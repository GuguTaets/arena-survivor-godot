extends Node2D

var speed = 400


func _process(delta):
	var direction = Vector2.ZERO

	if Input.is_action_pressed("ui_left"):
		direction.x -= 1
	if Input.is_action_pressed("ui_right"):
		direction.x += 1
	if Input.is_action_pressed("ui_up"):
		direction.y -= 1
	if Input.is_action_pressed("ui_down"):
		direction.y += 1

	# Normaliza para que o movimento na diagonal não seja mais rápido
	direction = direction.normalized()

	position += direction * speed * delta
