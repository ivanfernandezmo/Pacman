extends TileMap

onready var mida_mitja_cela = get_cell_size()/2
onready var jugador = get_parent().get_parent().get_node("pacman")
onready var enemicRed = get_parent().get_parent().get_node("Enemic")
onready var enemicPink = get_parent().get_parent().get_node("EnemicRosa")
onready var enemicBlue = get_parent().get_parent().get_node("EnemicBlau")
onready var enemicYellow = get_parent().get_parent().get_node("EnemicGroc")
onready var rosa = false;
onready var blau = false;
onready var groc = false;
var contFantasmas = 4;
var boost_activo = false  # Estado global del boost

func _ready():
	pass

func posicio_inicial():
	var pos = map_to_world(Vector2(14,23))#prova i error
	pos.y += mida_mitja_cela.y
	return pos

func hi_ha_espai(pos, direccio):
	var tile_actual = world_to_map(pos)
	var tile_seguent = get_cellv(tile_actual+direccio)
	var tile_seguent_pos = Vector2()
	if(tile_seguent == 12 or tile_seguent == 13 or tile_seguent == 14):
		tile_seguent_pos = map_to_world(tile_actual+direccio) + mida_mitja_cela
	else:
		tile_seguent_pos = recolocar(pos)
	return tile_seguent_pos

func recolocar(pos):
	var tile = world_to_map(pos)
	return map_to_world(tile) + mida_mitja_cela

func menjar(pos):
	var tile_actual = world_to_map(pos)
	var tile = get_cellv((tile_actual))
	if(tile == 12 or tile == 13):
		set_cellv(tile_actual, 14)
		if (tile == 13):
			#Modo asesino!!
			jugador.activar_boost()
			pass

# Activar boost (llamado por Pac-Man cuando come un tile especial)
func activar_boost():
	boost_activo = true
	if(enemicRed != null):
		enemicRed.cambiar_a_fantasma()
	if(enemicPink != null):
		enemicPink.cambiar_a_fantasma()
	if(enemicBlue != null):
		enemicBlue.cambiar_a_fantasma()
	if(enemicYellow != null):
		enemicYellow.cambiar_a_fantasma()
	yield(get_tree().create_timer(10), "timeout")  # Esperar 10 segundos
	desactivar_boost()

# Desactivar boost
func desactivar_boost():
	boost_activo = false
	if(enemicRed != null):
		enemicRed.restaurar_estado_normal()
	if(enemicPink != null):
		enemicPink.restaurar_estado_normal()
	if(enemicBlue != null):
		enemicBlue.restaurar_estado_normal()
	if(enemicYellow != null):
		enemicYellow.restaurar_estado_normal()

		
func _process(_delta):
	var contador=300;
	for i in range(get_used_rect().size.x):
		for j in range(get_used_rect().size.y):
			var tile = get_cell(i,j)
			if(tile == 12):
				contador -= 1
			if(tile == 13):
				contador -= 11.5
	
	if(contador >= 50 && !rosa): #Sale fantasma rosa
		rosa = true
		enemicPink.inicia()
		
	if(contador >= 100 && !blau): #Sale fantasma azul
		blau = true
		enemicBlue.inicia()
		
	if(contador >= 150 && !groc): #Sale fantasma amarillo
		groc = true
		enemicYellow.inicia()
		
	if(contador == 300 && contFantasmas == 0): #Fin! (Y fantasmas muertos??)
		print("Has guanyat! amb ", contador, " punts")
		set_process(false)
		
func get_pos_enemicRed():
	var pos = map_to_world(Vector2(14,11))
	pos.y += mida_mitja_cela.y
	return pos

func get_pos_enemicRosa():
	var pos = map_to_world(Vector2(14,14))
	pos.y += mida_mitja_cela.y
	return pos
	
func get_pos_enemicBlau():
	var pos = map_to_world(Vector2(12,14))
	pos.y += mida_mitja_cela.y
	return pos
	
func get_pos_enemicGroc():
	var pos = map_to_world(Vector2(16,14))
	pos.y += mida_mitja_cela.y
	return pos

func get_jugador():
	var path = get_parent().get_simple_path(enemicRed.position, jugador.position, false)
	return path
	
func get_jugador_rosa():
	var path = get_parent().get_simple_path(enemicPink.position, jugador.position, false)
	return path
	
func get_jugador_rosa_mov(anticipacio: Vector2) -> PoolVector2Array:
	if anticipacio == null:
		return PoolVector2Array()  # Devuelve un camino vacío si `anticipacio` no es válido
	return get_parent().get_simple_path(enemicPink.position, anticipacio, false)

func get_jugador_blau():
	var path = get_parent().get_simple_path(enemicBlue.position, jugador.position, false)
	return path

func get_jugador_groc():
	var path = get_parent().get_simple_path(enemicYellow.position, jugador.position, false)
	return path
	
func get_map_dimensions():
	return get_used_rect().size * get_cell_size()
	
func te_paret(posicio):
	var tile_actual = world_to_map(posicio)
	var tile = get_cellv(tile_actual)
	# 12, 13 y 14 son celdas sin paredes
	return not (tile == 12 or tile == 13 or tile == 14)

func enemicMort(color):
	if (color == "red"): enemicRed = null
	if (color == "pink"): enemicPink = null
	if (color == "blue"): enemicBlue = null
	if (color == "yellow"): enemicYellow = null
	contFantasmas -=1
