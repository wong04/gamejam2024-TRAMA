extends Node2D
@onready var dashicon: Sprite2D = $dashicon
@onready var gravicon: Sprite2D = $gravicon
@onready var superjumpicon: Sprite2D = $superjumpicon
@onready var walljumpicon: Sprite2D = $walljumpicon

func _process(delta: float) -> void:
	if Global.Ability[0]==0:
		dashicon.visible=true
		walljumpicon.visible=false
	elif Global.Ability[0]==1:
		dashicon.visible=false
		walljumpicon.visible=true
	if Global.Ability[1]==0:
		superjumpicon.visible=true
		gravicon.visible=false
	elif Global.Ability[1]==1:
		superjumpicon.visible=false
		gravicon.visible=true
	
