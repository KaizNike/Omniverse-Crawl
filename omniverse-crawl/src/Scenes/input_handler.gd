class_name InputHandler 
extends Node

@export var is_torch_out: bool = false

func get_action(player: Entity) -> Action:
	var action: Action = null
	var dir = Input.get_vector("ui_left","ui_right","ui_up","ui_down")
	if dir and (Input.is_action_just_pressed("ui_up") or Input.is_action_just_pressed("ui_down") or Input.is_action_just_pressed("ui_left") or Input.is_action_just_pressed("ui_right")):
		action = BumpAction.new(player,dir.x,dir.y)
	if Input.is_action_just_pressed("sneak"):
		action = SnuffTorchAction.new(player)
		is_torch_out = !is_torch_out
		action.is_torch_out = is_torch_out
	if Input.is_action_just_pressed("ui_cancel"):
		action = EscapeAction.new(player)
		
	return action
