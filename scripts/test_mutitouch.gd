extends Node2D

@onready var icon_container: Node = $icon_container

var icons = []
var touch_map: Dictionary = {} # เก็บว่า event.index ไหน คุม icon ตัวไหน

func _ready() -> void:
	for icon in icon_container.get_children():
		icons.append(icon)
	for i in icons:
		i.hide()

func _input(event: InputEvent) -> void:
	if event is InputEventScreenTouch:
		if event.is_pressed():
			# เมื่อมีนิ้วแตะลงมา: หา icon ที่ยังว่างอยู่เพื่อมาผูกกับนิ้วนี้
			if not touch_map.has(event.index):
				for i in range(icons.size()):
					if not touch_map.values().has(i):
						touch_map[event.index] = i
						icons[i].show()
						icons[i].global_position = event.position
						break
			else:
				var i = touch_map[event.index]
				icons[i].show()
				icons[i].global_position = event.position
		else:
			# เมื่อยกนิ้วขึ้น: ซ่อน icon ตัวที่ผูกไว้ และลบออกจาก touch_map
			if touch_map.has(event.index):
				var i = touch_map[event.index]
				icons[i].hide()
				touch_map.erase(event.index)

	elif event is InputEventScreenDrag:
		# เมื่อลากนิ้ว: อัปเดตตำแหน่งของ icon ตัวที่ผูกไว้กับนิ้วนี้
		if touch_map.has(event.index):
			var i = touch_map[event.index]
			icons[i].show()
			icons[i].global_position = event.position
