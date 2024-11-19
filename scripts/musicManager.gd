extends Node

@onready var musicPlayer: AudioStreamPlayer = $backgroundMusic

var no_music_scenes = ["Menu", "selection", "credits"]  # Scenes where music should not play

func _ready():
	musicPlayer.play()  # Start playing music when the manager is ready

func play_music():
	musicPlayer.set_stream_paused(false) # Start playing music if it's not already playing

func stop_music():
	musicPlayer.set_stream_paused(true)  # Stop the music if it is currently playing

func manage_music(current_scene: String):
	print(current_scene)  # For debugging, see which scene is active
	
	# Check if the current scene is in no_music_scenes
	if current_scene in no_music_scenes:
		stop_music()  # Stop music for selection screens
	else:
		play_music()  # Play music for level scenes
