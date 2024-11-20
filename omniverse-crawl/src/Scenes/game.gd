class_name Game
extends Node2D

const PLAYER_DEFINITION: EntityDefinition = preload("res://src/Entities/Actors/entity_definition_player.tres")

@onready var player: Entity
@onready var input_handler: InputHandler = $InputHandler
@onready var map: Map = $Map
@onready var camera: Camera2D = $Camera2D
@onready var torch: PointLight2D = $PointLight2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player = Entity.new(null, Vector2i.ZERO, PLAYER_DEFINITION)
	camera.reparent(player)
	torch.reparent(player)
	torch.offset = Vector2i(player.texture.get_size()/2)
	#var npc := Entity.new(player_start_pos + Vector2i.RIGHT,PLAYER_DEFINITION)
	#npc.modulate = Color.ORANGE
	#entities.add_child(npc)
	map.generate(player)
	map.update_fov(player.grid_position)


func _physics_process(delta: float) -> void:
	var action: Action = input_handler.get_action(player)
	if action:
		var previous_player_position: Vector2i = player.grid_position
		action.perform()
		_handle_enemy_turns()
		if action is SnuffTorchAction:
			if action.is_torch_out:
				map.fov_radius = 1
				torch.visible = false
			else:
				map.fov_radius = 8
				torch.visible = true
		if (player.grid_position != previous_player_position or 
		action is SnuffTorchAction):
			map.update_fov(player.grid_position)


func get_map_data() -> MapData:
	return map.map_data


func _handle_enemy_turns() -> void:
	for entity in get_map_data().entities:
		if entity == player:
			continue
		#print("The %s might take a turn someday, it stands defiantly." % entity.get_entity_name())
