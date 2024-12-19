extends Area2D

onready var parets = get_parent().get_node("Navigation2D/Parets")
var path = []
var direccio = Vector2(0,0)
var velocitat = 40
var estat_normal = true  # Indica si el enemigo está en su estado normal

func _ready():
	position = parets.get_pos_enemicGroc()
	$AnimatedSprite.play()
	set_process(false)
	
func inicia():
	position = parets.get_pos_enemicRed()
	path = parets.get_jugador_groc()
	set_process(true)
	
func _process(delta):
	if(path.size()>1):
		var posNova = path[0]
		direccio = (posNova-position).normalized()
		
		var distancia = position.distance_to(path[0])
		if (distancia > 1):
			position += velocitat * delta * direccio
		else:
			path.remove(0)
	else:
		path = parets.get_jugador_groc()
	
	if estat_normal:  # Solo cambia animación normal si no está en modo fantasma
		if direccio.x > 0.7:
			$AnimatedSprite.animation = "dreta"
		elif direccio.x < -0.7:
			$AnimatedSprite.animation = "esquerra"
		elif direccio.y > 0.7:
			$AnimatedSprite.animation = "baix"
		elif direccio.y < -0.7:
			$AnimatedSprite.animation = "dalt"

	teleportar();

func _end_game():
	get_tree().change_scene("res://escenes/Joc.tscn")

func teleportar():
	# Teletransportarse al otro lado si sale del mapa
	if position.x <= 1.9:  # Sale por la izquierda
		position.x = 222.0
	elif position.x >= 222.1:  # Sale por la derecha
		position.x = 2

func _on_EnemicGroc_area_entered(area):
	if (area.name == "pacman"):
		if (estat_normal):
			print("Has perdut")
			_end_game()
		else:
			# Incrementa la puntuación del jugador
			parets.enemicMort("yellow")
			# Elimina al enemigo
			queue_free()

# Función para cambiar a modo fantasma
func cambiar_a_fantasma():
	estat_normal = false
	$AnimatedSprite.animation = "fantasma"

# Función para restaurar el estado normal
func restaurar_estado_normal():
	estat_normal = true
	$AnimatedSprite.animation = "dreta" 
