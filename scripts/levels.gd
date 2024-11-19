extends Node2D

func _ready():
	var current_scene = get_tree().current_scene.name  # Get the name of the current scene
	MusicManager.manage_music(current_scene)  # Manage music based on the current scene
