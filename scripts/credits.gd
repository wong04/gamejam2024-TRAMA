extends Node2D

@onready var creditsMusic: AudioStreamPlayer = $AudioStreamPlayer
@onready var knightemote: AnimatedSprite2D = $Knightemote
@onready var goblinemote: AnimatedSprite2D = $Goblinemote
@onready var knightemote_2: AnimatedSprite2D = $Knightemote2
@onready var goblinemote_2: AnimatedSprite2D = $Goblinemote2
@onready var knightemote_3: AnimatedSprite2D = $Knightemote3
@onready var goblinemote_3: AnimatedSprite2D = $Goblinemote3
@onready var knightemote_4: AnimatedSprite2D = $Knightemote4
@onready var goblinemote_4: AnimatedSprite2D = $Goblinemote4


func _ready() -> void:
	knightemote.play()
	goblinemote.play()
	knightemote_2.play()
	goblinemote_2.play()
	knightemote_3.play()
	goblinemote_3.play()
	knightemote_4.play()
	goblinemote_4.play()
	creditsMusic.play()
