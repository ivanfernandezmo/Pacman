extends Area2D

onready var parets = get_parent().get_node("Navigation2D/Parets")
var path = []
var direccio = Vector2(0,0)
var velocitat = 25

func _ready():
	position = parets.get_pos_enemicRed()
	path = parets.get_jugador()
	
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
		path = parets.get_jugador()
	teleportar();


func _on_Enemy_area_entered(area):
	if (area.name == "pacman"):
		print("Has perdut")
		_end_game()

func _end_game():
	get_tree().change_scene("res://escenes/Joc.tscn")

func teleportar():
	# Teletransportarse al otro lado si sale del mapa
	if position.x <= 1.9:  # Sale por la izquierda
		position.x = 222.0
	elif position.x >= 222.1:  # Sale por la derecha
		position.x = 2
