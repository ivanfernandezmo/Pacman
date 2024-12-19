extends CanvasLayer  # Usamos CanvasLayer para que esté sobre la vista del juego

onready var iniciar_button = $Control/Button
onready var cartel_text = $Control/Label

var juego_iniciado = false  # Estado que controla si el juego ha comenzado

func _ready():
	# Inicializamos el cartel con el texto y el botón
	cartel_text.text = "Iniciar partida"
	
	# Conectamos la señal del botón para que cuando sea presionado, se inicie la partida
	iniciar_button.connect("pressed", self, "_on_iniciar_button_pressed")

	# Ocultamos el cartel inicialmente
	$Control.visible = true  # Si se quiere mostrar el cartel
	
	

func _on_iniciar_button_pressed():
	if !juego_iniciado:
		
		# Cambiamos el estado a iniciado
		juego_iniciado = true
		
		# Iniciamos el juego: Eliminar cartel, inicializar jugadores, fantasmas, etc.
		$Control.visible = false  # Ocultamos el cartel
		iniciar_partida()

		# Aquí puedes empezar el juego, por ejemplo, llamando a una función en tu mapa o jugador.
		get_tree().call_group("juego", "iniciar_partida")  # Llamamos a la función global de inicio del juego
	else:
		print("El joc ja ha començat.")
		
func iniciar_partida():
	# Aquí se puede colocar la lógica para iniciar la partida
	# Ejemplo: inicializar personajes, establecer el estado del juego, etc.
	print("El joc ha començat.")
	# Puedes inicializar tus enemigos, el jugador, las puntuaciones, etc.
