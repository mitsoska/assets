extends Node2D

@onready var NutrientsL = $Nutrients
@onready var NPS = $"Nutrients per sec"
@onready var NE = $"Not enough"
@onready var redsG = $reds
@onready var orangeG = $oranges
@onready var darksG = $darks
@onready var blueG = $blues
@onready var progress_bar = $ProgressBar
@onready var indicators = $Indicators

@export var redGPS = 1
@export var orgGPS = 4
@export var drkGPS = 8
@export var blsGPS = 10

var extra_scene = preload("res://scenes/extra.tscn")

var bar_progress = 0
# Progress-bar related cosntants, adjust them!
# The maximum size of the bar in pixels
const maximum_bar_progress: int = 488
# How much nutrition you get when the bar goes full
const nutrition_from_bar: int = 20

var reds = 0
var oranges = 0
var darks = 0
var blues = 0
var nutrition = 5
var nps = 0
var interval = 1.0
var timePassed = 0.0
var RG = 0
var OG = 0
var DG = 0
var BG = 0

func ready() -> void:
	pass

func Passive():
	await get_tree().create_timer(1.0).timeout
	nps = RG + OG + DG + BG
	nutrition += nps
	

func update():
	for i in range(redsG.get_child_count()):
		redsG.get_child(i).visible = false
		
	for i in range(orangeG.get_child_count()):
		orangeG.get_child(i).visible = false
	
	for i in range(darksG.get_child_count()):
		darksG.get_child(i).visible = false
	
	for i in range(blueG.get_child_count()):
		blueG.get_child(i).visible = false
	
	for j in range(0, oranges):
		orangeG.get_child(j).visible = true
	
	for j in range(0, darks):
		darksG.get_child(j).visible = true
	
	for j in range(0, blues):
		blueG.get_child(j).visible = true
	
	for j in range(0, reds):
		redsG.get_child(j).visible = true

func _process(delta: float) -> void:
	timePassed += delta
	if timePassed >= interval:
		Passive()
		timePassed = 0.0
		
	update()
	
	NutrientsL.text = str(nutrition)
	NPS.text = "Nutrition/s: " + str(nps)

func _on_buy_red_pressed() -> void:
	
	if nutrition >= 5 and reds != 11:
		$AudioStreamPlayer.playing = true
		nutrition -= 5
		reds += 1
		RG += 1
	elif nutrition < 5:
		NE.text = "not enough nuketrition"
		$AudioStreamPlayer3.play()
		NE.visible = true
		await get_tree().create_timer(1.0).timeout
		NE.visible = false

func _on_audio_stream_player_2_finished() -> void:
	$AudioStreamPlayer2.play()

func _on_merge_red_pressed() -> void:
	if oranges != 11:
		if reds >= 5:
			$AudioStreamPlayer.playing = true
			reds -= 5
			oranges += 1
			RG -= 5
			OG += 4
		else:
			NE.text = "not enough plants"
			$AudioStreamPlayer3.play()
			NE.visible = true
			await get_tree().create_timer(1.0).timeout
			NE.visible = false

func _on_merge_orange_pressed() -> void:
	if darks != 12:
		if oranges >= 8:
			$AudioStreamPlayer.playing = true
			oranges -= 8
			darks += 1
			OG -= 8 * 4
			DG += 6
		else:
			NE.text = "not enough plants"
			$AudioStreamPlayer3.play()
			NE.visible = true
			await get_tree().create_timer(1.0).timeout
			NE.visible = false

func _on_merge_dark_pressed() -> void:
	if blues != 12:
		if darks >= 10:
			$AudioStreamPlayer.playing = true
			darks -= 10
			blues += 1
			DG -= 10 * 6
			BG += 8
		else:
			NE.text = "not enough plants"
			$AudioStreamPlayer3.play()
			NE.visible = true
			await get_tree().create_timer(1.0).timeout
			NE.visible = false

func _on_earth_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	# Check if the player has clicked on earth, and if they have
	# Increment the progress bar. If it's fool, update nutrition
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		bar_progress += 10
		# Spawn a +1 icon
		var extra = extra_scene.instantiate()
		extra.global_position = get_global_mouse_position()
		indicators.add_child(extra)
		
		# Check I've the bar is done
		if bar_progress > maximum_bar_progress:
			bar_progress = 0
			nutrition += nutrition_from_bar
		
		# Scale the progress sprite so it reflects the state
		progress_bar.get_node("Progress").size.x = bar_progress
