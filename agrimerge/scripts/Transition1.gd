extends Node

@onready var animplr = $AnimationPlayer
@onready var colorR = $ColorRect

func _ready() -> void:
	colorR.visible = true
	animplr.play("Fade_in")
	await animplr.animation_finished
	colorR.visible = false
