extends Area2D

@onready var timer: Timer = $Timer

func _on_body_entered(body: Node2D) -> void:
	Engine.time_scale=0.5
	body.get_node("CollisionShape2D").queue_free()
	Global.keys_collected=false
	timer.start()

func _on_timer_timeout() -> void:
	Engine.time_scale = 1
	#Global.justDied=false
	get_tree().change_scene_to_file("res://scenes/selection.tscn")
