extends Area2D
@onready var door: Area2D = $"../Door"
@onready var key: AnimatedSprite2D = $AnimatedSprite2D

func _ready():
	key.play()

func _on_body_entered(body: Node2D) -> void:
	Global.keys_collected = true
	queue_free() # Replace with function body.
