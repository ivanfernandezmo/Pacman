extends Area2D

var direccio = Vector2(0, 0)
var VELOCITAT = 50  # Ajusta la velocidad según sea necesario
onready var parets = get_parent().get_node("Navigation2D/Parets")
var boost_activo = false  # Indica si el boost está activo
onready var timer_boost = $TimerBoost  # Referencia al temporizador


func _ready():
	$AnimatedSprite.play("moviment")
	position = parets.posicio_inicial()
	timer_boost.connect("timeout", self, "_on_TimerBoost_timeout")

func _process(delta):
	# Detectar la dirección
	if Input.is_action_pressed("ui_up"):
		direccio = Vector2(0, -1)
		rotation = deg2rad(-90)
	if Input.is_action_pressed("ui_down"):
		direccio = Vector2(0, 1)
		rotation = deg2rad(90)
	if Input.is_action_pressed("ui_left"):
		direccio = Vector2(-1, 0)
		rotation = deg2rad(180)
	if Input.is_action_pressed("ui_right"):
		direccio = Vector2(1, 0)
		rotation = deg2rad(0)
	
	# Calcular la siguiente posición sin ajustar a la celda
	var nova_posicio = position + direccio * VELOCITAT * delta

	# Verificar si hay colisión con las paredes
	if not parets.te_paret(nova_posicio):
		position = nova_posicio
		parets.menjar(position)

	# Verificar si sale del mapa para teletransportarse
	teleportar()
	

func teleportar():
	# Teletransportarse al otro lado si sale del mapa
	if position.x <= 1.9:  # Sale por la izquierda
		position.x = 222.0
	elif position.x >= 222.1:  # Sale por la derecha
		position.x = 2

# Activar el boost cuando Pac-Man coma un tile especial
func activar_boost():
	boost_activo = true
	VELOCITAT = 100
	$AnimatedSprite.speed_scale = 8  # Acelera la animación al doble
	timer_boost.start(10)  # Activa el temporizador para 10 segundos
	parets.activar_boost()  # Notifica a los enemigos que cambien a modo fantasma
	
# Restaurar el estado normal después del boost
func _on_TimerBoost_timeout():
	boost_activo = false
	VELOCITAT = 50
	$AnimatedSprite.speed_scale = 5  # Restaura la velocidad normal de la animación
