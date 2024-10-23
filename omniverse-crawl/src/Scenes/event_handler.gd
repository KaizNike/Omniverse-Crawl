class_name EventHandler
extends Node


func get_action() -> Action:
	var action: Action = null
	var dir = Input.get_vector("ui_left","ui_right","ui_up","ui_down")
	if dir and (Input.is_action_just_pressed("ui_up") or Input.is_action_just_pressed("ui_down") or Input.is_action_just_pressed("ui_left") or Input.is_action_just_pressed("ui_right")):
		action = MovementAction.new(dir.x,dir.y)
	if Input.is_action_just_pressed("ui_cancel"):
		action = EscapeAction.new()
		
	return action
