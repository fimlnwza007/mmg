extends Node2D

@onready var icon_container: Node = $icon_container

var icons = []


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
		for icon in icon_container.get_children():
			icons.append(icon)

func _input(event):
	if event is InputEventScreenDrag:
		var i = event.index
		if i < icons.size():
			icons[i].show()
			icons[i].global_position = event.position
	if event is InputEventScreenTouch and not event.is_pressed():
		var i = event.index
		icons[i].hide()
