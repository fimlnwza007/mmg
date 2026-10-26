extends Node2D

@onready var icon_container: Node = $icon_container

var icons = []

func _ready() -> void:
	for icon in icon_container.get_children():
		icons.append(icon)
	for i in icons:
		i.hide()

func _input(event: InputEvent) -> void:
	# 1. จัดการตอนแตะนิ้วลง หรือยกนิ้วขึ้น
	if event is InputEventScreenTouch:
		var i = event.index
		if i < icons.size():
			if event.is_pressed():
				icons[i].show()
				icons[i].global_position = event.position
			else:
				icons[i].hide()

	# 2. จัดการตอนลากนิ้วไปมาบนจอ
	elif event is InputEventScreenDrag:
		var i = event.index
		if i < icons.size():
			icons[i].show()
			icons[i].global_position = event.position

	# 3. Fallback: กรณี Browser ส่งเป็น Mouse Event แทน Touch Event
	elif event is InputEventMouseButton:
		if icons.size() > 0:
			if event.is_pressed():
				icons[0].show()
				icons[0].global_position = event.position
			else:
				icons[0].hide()
	elif event is InputEventMouseMotion and (event.button_mask & 1):
		if icons.size() > 0:
			icons[0].show()
			icons[0].global_position = event.position
