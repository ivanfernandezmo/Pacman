extends Area2D

var direccio = Vector2(0,0)
var VELOCITAT = 10
onready var parets = get_parent().get_node("Parets")

func _ready():
	$AnimatedSprite.play("moviment")
	position = parets.posicio_inicial()
	
func _process(delta):
	if Input.is_action_pressed("ui_up"):
		#moure amunt
		direccio=Vector2(0,-1)
		rotation = deg2rad(-90)
	elif Input.is_action_pressed("ui_down"):
		#moure amunt
		direccio=Vector2(0,1)
		rotation = deg2rad(90)
	elif Input.is_action_pressed("ui_left"):
		#moure amunt
		direccio=Vector2(-1,0)
		rotation = deg2rad(180)
	elif Input.is_action_pressed("ui_right"):
		#moure amunt
		direccio=Vector2(1,0)
		rotation = deg2rad(0)
	
	var posicio_a_moure = parets.hi_ha_espai(position, direccio)
	if(direccio != Vector2(0,0)):
		position = position.linear_interpolate (posicio_a_moure, VELOCITAT * delta)
		parets.menjar(position)
	
