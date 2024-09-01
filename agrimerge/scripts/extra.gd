extends Node2D

@onready var anim_player = $AnimationPlayer

func _ready() -> void:
	anim_player.play("fade")
	
	# Delete once the animation has finished
	await anim_player.animation_finished
	queue_free()
