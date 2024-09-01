extends Node

func _on_hover_red_mouse_entered() -> void:
	$"Merge red".visible = true

func _on_hover_red_mouse_exited() -> void:
	$"Merge red".visible = false

func _on_hover_orange_mouse_entered() -> void:
	$"Merge Orange".visible = true

func _on_hover_orange_mouse_exited() -> void:
	$"Merge Orange".visible = false

func _on_hover_dark_mouse_entered() -> void:
	$"Merge Dark".visible = true

func _on_hover_dark_mouse_exited() -> void:
	$"Merge Dark".visible = false
