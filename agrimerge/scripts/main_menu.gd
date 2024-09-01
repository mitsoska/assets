extends Node2D

@onready var AudioPlayer = $AudioStreamPlayer
@onready var AnimPlayer = $AnimationPlayer
@onready var ColorR = $AnimationPlayer/ColorRect
@onready var video = $VideoStreamPlayer

func _on_play_pressed() -> void:
	print("Hello?")
	AudioPlayer.play()
	ColorR.visible = true
	AnimPlayer.play("Fade_out")
	await AnimPlayer.animation_finished
	get_tree().change_scene_to_file("res://scenes/Main.tscn")


func _on_options_pressed() -> void:
	AudioPlayer.play()
	ColorR.visible = true
	AnimPlayer.play("Fade_out")
	await AnimPlayer.animation_finished
	get_tree().change_scene_to_file("res://scenes/Options.tscn")

func _ready() -> void:
	# Wait for the video to stop and make it invisible
	await video.finished
	video.visible = false

func _on_credits_pressed() -> void:
	AudioPlayer.play()
	if $Panel.visible == false:
		$Panel.visible = true
	else:
		$Panel.visible = false
