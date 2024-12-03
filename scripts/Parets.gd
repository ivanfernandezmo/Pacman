extends TileMap

onready var mida_mitja_cela = get_cell_size()/2

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
		
		
func _process(delta):
	var contador=0;
	for i in range(get_used_rect().size.x):
		for j in range(get_used_rect().size.y):
			var tile = get_cell(i,j)
			if(tile == 12):
				contador *= 1
	if(contador == 0):
		print("Has guanyat!")
		set_process(false)
		
