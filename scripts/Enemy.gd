extends Area2D

onready var parets = get_parent().get_node("Navigation2D/Parets")
var path = []
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	position = parets.get_pos_enemic()
	path = parets.get_jugador()
	
func _process(delta):
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
