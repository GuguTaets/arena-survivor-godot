extends Node2D

@onready var timer = get_node("Timer")
@onready var label = $Label

var speed = 400

func _ready():
	print("Cena carregada!")
	set_process(is_processing())

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

func _input(event):
	# O _input continua rodando mesmo com o _process desligado.
	# Se o _process está ativo, o movimento funciona normal e não avisamos nada.
	if is_processing():
		return

	if event.is_pressed() and not event.is_echo():
		print("Controles desativados! Aguarde alguns instantes.")


func _on_button_pressed():
	print("Botão pressionado!")
	timer.one_shot = true
	timer.set_wait_time(5.0) 						# Define o tempo de espera do timer para 5 segundos
	timer.start()
	set_process(not is_processing()) 				# Desativa o processamento enquanto o timer está ativo
	visible = not visible							# Oculta o Node2D enquanto o timer está ativo
	timer.timeout.connect(_on_timer_timeout)


func _on_timer_timeout():
	print("Tempo esgotado!")
	set_process(not is_processing())
	visible = not visible
